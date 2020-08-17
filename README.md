# Motoko Graph

![build](https://github.com/matthewhammer/motoko-graph/workflows/build/badge.svg)

Graphical data models for Motoko.

Eventual goals:
 - General-purpose interface (e.g., see [OCamlgraph](http://ocamlgraph.lri.fr/index.en.html))
 - Infinite scaling (a la [scalable maps for the Internet Computer](https://github.com/dfinity/motoko-bigmap))


-------------------------

## Design

This library supports generic graph-based data models and their
associated query algorithms (all paths, shortest path, min cut).

### Potential applications:

- [Entity-relationship models](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model), for relational queries.
- [Sequence diagrams](https://en.wikipedia.org/wiki/Sequence_diagram), for event-based modeling.
- [Dependency graphs](https://en.wikipedia.org/wiki/Dependency_graph), for interactive and/or incremental systems:
  - [Dynamic dependency graphs (producer/consumer relationships)](https://en.wikipedia.org/wiki/Incremental_computing#Dynamic_methods)
  - [Demanded computation graphs](https://arxiv.org/abs/1503.07792)
  - [Demanded abstract interpretation graphs]((https://github.com/cuplv/d1a_impl)), for static program analysis.
- [Probabilistic / graphical models](https://en.wikipedia.org/wiki/Graphical_model), for machine learning.

### Mathematical properties (Graph structure specifics)

#### The API design choices

1. Edges are uniquely identifed.
2. Edges are ordered.
3. [Multigraphs](https://en.wikipedia.org/wiki/Multigraph) supported.

#### Rationale

1. Dynamic dependency graphs require all three choices, generally.

2  Less structured (undirected, unordered) graphs can be
   encoded into this richer structure, but the reverse is not true.

### (1) Edges are uniquely identifed

Upon creation, the API issues a unique id for each edge in the graph.

Edge identities are (totally-ordered) positions in the sequence of all graph edges.

Each position consists of graphical edge information:
A source-target node pair, and a domain-specific edge label.

The position may be updated with new edge information,
retaining the same edge identity (ordered position).

### (2) Edges are ordered

The set of edges is ordered totally, though future revisions may relax ordering to a partial one.

Adding edges appends edges to this total order, at the end.

The "local ordering" of incoming and outgoing edges at each node is
consistent with the global total ordering; hence, the total ordering
suffices to define all local orderings (both incoming and outgoing).

### (3) Multigraphs

Multigraphs permit multiple edges to coexist, independently, between a
single pair of nodes. This support is critical for many applications.

The API distinguishes distinct edges by their (distinct) positions in
the total order, not their source-target-label triple.


