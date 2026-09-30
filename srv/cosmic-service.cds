using {galactic} from '../db/schema';

service CosmicService @(requires: 'authenticated-user') {

    /**
     * Restricts access to spacefarers based on their origin planet.
     * Grant spacefares with manager role the ability to create, update, and delete spacefarers from their own origin planet.
     */
    @restrict: [
        {
            grant: ['READ'],
            to   : 'spacefarer',
            where: (originPlanet = $user.originPlanet)
        },
        {
            grant: ['WRITE'],
            to   : 'manager',
            where: (originPlanet = $user.originPlanet)
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