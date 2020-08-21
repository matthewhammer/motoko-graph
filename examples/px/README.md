# Produce Exchange

Example of `motoko-graph` package for a marketplace-like data model.

 - Data encoded as graph structure (entities are nodes, inter-relationships are edges)
 - Queries encoded as graph queries over graph's node-edge structure

### Data model

The produce exchange is interesting as an example because it features
a relatively involved data model, and several important relationships
that change over time.

#### Entities

- Retailers that sell produce
- Producers that produce produce
- Truckers that transport produce

#### Resource relationships

The produce exchange permits produce retailers to consume the resources of other entities:

- Trucking routes (published by truckers, queried by retailers)
- Produce inventory (published by producers, queried by retailers)

In the graphical encoding, we represent each region, route and
inventory listing as a graph node.  Edges connect them in different
ways, supporting different queries by the retailers.
