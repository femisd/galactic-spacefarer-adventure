using {galactic} from '../db/schema';

service CosmicService @(requires: 'authenticated-user') {

    /**
     * Restricts access to spacefarers based on their origin planet.
     * Grant spacefares with the highest security clearance (5) the ability to create, update, and delete spacefarers from their origin planet.
     */
    @restrict: [
        {
            grant: 'READ',
            to   : 'spacefarer',
            where: (originPlanet = $user.originPlanet)
        },
        {
            grant: [
                'CREATE',
                'UPDATE',
                'DELETE'
            ],
            to   : 'spacefarer',
            where: (originPlanet = $user.originPlanet
            and     $user.securityClearance = 5)
        },
        {
            grant: '*',
            to   : 'admin'
        }
    ]
    entity Spacefarers as projection on galactic.Spacefarers;

    @readonly
    entity Departments as projection on galactic.Departments;

    @readonly
    entity Positions   as projection on galactic.Positions;
}

annotate CosmicService.Spacefarers with @(odata.draft.enabled);