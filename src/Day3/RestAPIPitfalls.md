# Pitfalls of designing REST APIs

[summary](https://devoxx.be/talk/top-rest-api-design-pitfalls/)

## ADR
make use of an Architecture Decision Record

## Semantic versioning
- Major: breaking changes
- Minor: new features
- Patch: bug fixes

## Resolve by
- track impacted clients with
  - authentication tokens, traceIDs
- versioning and expose 2+ versions for a limited amount of time

> Do not make your API future-proof but future friendly. Don't add fields that might be used in the future.

## Automated contract testing
Detect accidental breaking changes in a contract

> Do not expose yourt domain model to the outside world. Use ViewModels (DTOs) instead.
> Separate contract from implementation.

> API design can hurt performance
- DOnt serialize ORM entities, use DTOs - could trigger lazy loading from DB
- Since 2021 a GET can have a body
- evaluate Proxy responses in micro services - could trigger multiple calls
  - ZipKit is a tool for distributed tracing

> watch CQRS by Greg young [link](https://www.youtube.com/watch?v=JHGkaShoyNs)

## intentional API design
- less concurrency risks
- POssibly More screens, possibly more APIs
- More obvious to clients

> Anything you do religiously, will bring you trouble

> read up: REST next level: Crafting domain-driven web APIS by Julien Topcu [link](https://www.youtube.com/watch?v=bHc8Gudrhdo&ab_channel=Devoxx)


## Error handling
- 400: return all failures in a single response as in a list with all items not nullable
- 500: return a single error message with error code and maybe error ID

## pitfalls
- too many breaking changes
- leak sensitive data
- expose internal domain model
- force clients to remote call in loop
- resuse DTOs for create and read

