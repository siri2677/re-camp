# Service architecture direction

The game starts as an offline client, but its save boundary is prepared for a live service.

```text
Unity client
  -> IPlayerSaveRepository
      -> LocalJsonSaveRepository (offline / guest player)
      -> future HttpPlayerSaveRepository (authenticated player)
          -> API -> database
```

## Why the database is deferred

An MVP or offline build has no need for a network database. The local repository provides a deterministic guest save and version number now. When accounts and cloud saves are introduced, an HTTP repository can implement the same interface without moving game rules into the backend.

## Required before a public launch

1. Choose an identity provider and implement guest/account login.
2. Implement the HTTP repository with authenticated requests and revision conflict handling.
3. Persist player save snapshots in a managed database and add backups.
4. Add telemetry, crash reporting, admin tooling, and remote game-data delivery.
5. Add rate limiting, authorization, privacy retention/deletion flows, and monitoring.
