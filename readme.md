# Galactic Spacefarer Adventure

A SAP CAP application for managing galactic spacefarer records. The project combines data models, a secure OData service, and a SAP Fiori Elements for managing spacefarers across the SAP galaxy.

## Project structure

- [db/schema.cds](db/schema.cds) — Data model for Spacefarers, Departments, and Positions
- [srv/cosmic-service.cds](srv/cosmic-service.cds) — Service definition and authorization rules
- [srv/cosmic-service.js](srv/cosmic-service.js) — Custom event handlers
- [app/spacefarers](app/spacefarers) — SAP Fiori frontend
- [db/data](db/data) — CSV seed data for reference entities
- [db.sqlite](db.sqlite) — local SQLite database used during development

## Authentication

The project uses CAP's mocked authentication in [package.json](package.json). Built-in sample accounts include:

`username` | `password` | `roles` | `planet`
-----|-----|----|----
admin | admin | `admin` | -
mike | mike123 | `spacefarer` `manager`| Planet X
john | john123 | `spacefarer` `manager`| Planet Y
rachel | rachel123 | `spacefarer` | Planet X
steve | steve123 | `spacefarer` | Planet Y

These users are assigned roles such as `admin`, `manager`, and `spacefarer`.


## Usage

1. Install node dependencies:

   ```bash
   npm install
   ```

2. Start the CAP service:

   ```bash
   cds watch
   ```

3. Open the application in a browser:

   ```text
   http://localhost:4004/
   ```
