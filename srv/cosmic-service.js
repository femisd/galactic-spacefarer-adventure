import cds from '@sap/cds'
import nodemailer from "nodemailer";

export class CosmicService extends cds.ApplicationService {
  init() {

    const { Spacefarers } = cds.entities('CosmicService')

    this.before('CREATE', Spacefarers, async (req) => {
      await validateSpacefarerRegistration(req)
      await assignStardustCollectionBonus(req.data)
      await assignWormholeNavigationSkillTraining(req.data)
    })

    this.before('UPDATE', Spacefarers, async (req) => {
      await validateSpacefarerRegistration(req)
    })


    this.after('CREATE', Spacefarers, async (spacefarers, req) => {
      await sendRegistrationNotificationEmail(spacefarers)
    })

    return super.init()
  }
}

async function validateSpacefarerRegistration(req) {
  /**
   * Validate that spacefarers are registered to the correct origin planet 
   * and that their stardust collection and wormhole navigation skill are within acceptable ranges.
   */
  const { originPlanet, stardustCollection, wormholeNavigationSkill } = req.data
  const managersOriginPlanet = req.user?.attr?.originPlanet
  if (!req.user.is('admin') && originPlanet !== managersOriginPlanet) {
    return req.reject(403, `You are only authorized to manage spacefarer registrations from ${managersOriginPlanet}.`)
  }

  if (!stardustCollection || stardustCollection < 0) {
    return req.reject(400, 'Stardust collection must be a non-negative number.')
  }

  if (!wormholeNavigationSkill || wormholeNavigationSkill < 0 || wormholeNavigationSkill > 100) {
    return req.reject(400, 'Wormhole navigation skill must be a number between 0 and 100.')
  }
}

async function assignStardustCollectionBonus(spacefarer) {
  /**
   * Assign a stardust collection bonus to spacefarers with high wormhole navigation skill levels.
   */
  const highSkillThreshold = 70
  if (spacefarer.wormholeNavigationSkill > highSkillThreshold) {
    spacefarer.stardustCollection += 50
  }
}

async function assignWormholeNavigationSkillTraining(spacefarer) {
  /**
   * Assign basic wormhole navigation skill training to spacefarers with high security clearance but low skill levels.
   */
  const highSecurityClearanceThreshold = 3 // Clearance level at which spacefarers are eligible for skill training
  const minimumSkillThreshold = 50 // Spacefarers starting with skill level below this threshold will receive basic training
  const skillTrainingGain = 30 // Amount of skill points gained from basic training

  const secClearanceCol = await SELECT.from('Positions', { ID: spacefarer.position_ID }, position => { position.securityClearance })
  if (secClearanceCol.securityClearance >= highSecurityClearanceThreshold && spacefarer.wormholeNavigationSkill < minimumSkillThreshold) {
    spacefarer.wormholeNavigationSkill += skillTrainingGain
  }
}

async function sendRegistrationNotificationEmail(spacefarer) {
  /**
   * Send a notification email to the spacefarer upon successful registration.
   */
  const transporter = nodemailer.createTransport({
    service: process.env.EMAIL_SERVICE,
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS
    }
  })

  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: spacefarer.email,
    subject: 'Spacefarer Registration Successful',
    text: `Dear ${spacefarer.name},\n\nYour registration as a spacefarer has been successfully completed. Welcome aboard!\n\nBest regards,\nGalactic Spacefarer Adventure Team`
  }

  try {
    await transporter.sendMail(mailOptions)
  } catch (error) {
    console.error('Error sending registration notification email:', error)
  }
}

