namespace galactic;

using { cuid, managed } from '@sap/cds/common';

/**
 * Registered Spacefarers.
 */
entity Spacefarers : cuid, managed {
    name                    : String @mandatory;
    stardustCollection      : Integer default 0 @assert.range: [0, _];
    wormholeNavigationSkill : Integer default 0 @assert.range: [0, 100];
    originPlanet            : String @mandatory;
    spacesuitColor          : String;
    department              : Association to Departments;
    position                : Association to Positions;    
}

/**
 * Departments spacefarers may belong to.
 * (e.g. Engineering, Logistics, Command, etc.)
 */
entity Departments : cuid, managed {
    name        : String @mandatory;
    description : String;
    spacefarers : Association to many Spacefarers on spacefarers.department = $self;
}

/**
 * Positions spacefarers may hold within departments.
 * (e.g. Captain, Engineer, Navigator, etc.)
 */
entity Positions : cuid, managed {
    title             : String @mandatory;
    description       : String;
    securityClearance : Integer default 1 @assert.range: [1, 5]; // Level of access on a spaceship/station. 1 = lowest, 5 = highest
    spacefarers       : Association to many Spacefarers on spacefarers.position = $self;
}