using CosmicService as service from '../../srv/cosmic-service';
annotate service.Spacefarers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : position.title,
            Label : 'Position',
        },
        {
            $Type : 'UI.DataField',
            Value : department.name,
            Label : 'Department',
        },
        {
            $Type : 'UI.DataField',
            Value : originPlanet,
            Label : 'Origin Planet',
        },
        {
            $Type : 'UI.DataField',
            Value : spacesuitColor,
            Label : 'Spacesuit Color',
        },
        {
            $Type : 'UI.DataField',
            Value : stardustCollection,
            Label : 'Stardust Collection',
        },
        {
            $Type : 'UI.DataField',
            Value : wormholeNavigationSkill,
            Label : 'Wormhole Navigation Skill',
        },
    ],
    UI.SelectionFields : [
        name,
        originPlanet,
        position.title,
        department.name,
    ],
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : position.title,
        },
        TypeImageUrl : 'sap-icon://customer',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Spacefarer Details',
            ID : 'SpacefarerRegistration',
            Target : '@UI.FieldGroup#SpacefarerRegistration',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Role',
            ID : 'Role',
            Target : '@UI.FieldGroup#Role',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Equipment',
            ID : 'Equipment',
            Target : '@UI.FieldGroup#Equipment',
        },
    ],
    UI.FieldGroup #SpacefarerRegistration : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : originPlanet,
                Label : 'Origin Planet',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : 'Email',
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
                Label : 'Registration Date',
            },
        ],
    },
    UI.FieldGroup #Equipment : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : stardustCollection,
                Label : 'Stardust Collection',
            },
            {
                $Type : 'UI.DataField',
                Value : spacesuitColor,
                Label : 'Spacesuit Color',
            },
        ],
    },
    UI.FieldGroup #Role : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : department.name,
                Label : 'Department',
            },
            {
                $Type : 'UI.DataField',
                Value : position.title,
                Label : 'Position',
            },
            {
                $Type : 'UI.DataField',
                Value : position.description,
                Label : 'Duties',
            },
            {
                $Type : 'UI.DataField',
                Value : position.securityClearance,
                Label : 'Security Clearance',
            },
            {
                $Type : 'UI.DataField',
                Value : wormholeNavigationSkill,
                Label : 'Wormhole Navigation Skill',
            },
        ],
    },
);

annotate service.Spacefarers with {
    name @Common.Label : 'name'
};

annotate service.Spacefarers with {
    originPlanet @Common.Label : 'originPlanet'
};

annotate service.Positions with {
    title @Common.Label : 'position/title'
};

annotate service.Departments with {
    name @Common.Label : 'department/name'
};

