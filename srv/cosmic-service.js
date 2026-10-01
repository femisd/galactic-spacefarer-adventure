import cds from '@sap/cds'

export class CosmicService extends cds.ApplicationService {
  init() {

    const { Spacefarers } = cds.entities('CosmicService')

    this.before('CREATE', Spacefarers, (req) => {
      validateSpacefarerRegistration(req)
      assignWormholeNavigationSkillTraining(req.data)
      assignStardustCollectionBonus(req.data)
    })

    this.after('CREATE', Spacefarers, (spacefarers, req) => {

    })

    return super.init()
  }
}


function validateSpacefarerRegistration(req) {
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

function assignWormholeNavigationSkillTraining(spacefarer) {
  /**
   * Assign wormhole navigation skill training to spacefarers with low skill levels, if they have high security clearance.
   */
  if (spacefarer.wormholeNavigationSkill < 50 && spacefarer.position.securityClearance >= 3) {
    spacefarer.wormholeNavigationSkill += 20
  }
}

function assignStardustCollectionBonus(spacefarer) {
  /**
   * Assign a stardust collection bonus to spacefarers with high wormhole navigation skill levels.
   */
  if (spacefarer.wormholeNavigationSkill > 70) {
    spacefarer.stardustCollection += 50
  }
}

