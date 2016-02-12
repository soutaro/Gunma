# Gunma

[![Build Status](https://travis-ci.org/soutaro/Gunma.svg?branch=master)](https://travis-ci.org/soutaro/Gunma)

Gunma is a graph library for Swift. It provides basic graph structure and implementations for Strongly Connected Components and Topological Sort.

```swift
// From https://en.wikipedia.org/wiki/Strongly_connected_component

var graph = Graph<String>()

graph.addVertex("a")
graph.addVertex("b")
graph.addVertex("c")
graph.addVertex("d")
graph.addVertex("e")
graph.addVertex("f")
graph.addVertex("g")
graph.addVertex("h")

graph.addEdge(from: "a", to: "b")
graph.addEdge(from: "b", to: "c")
graph.addEdge(from: "b", to: "f")
graph.addEdge(from: "b", to: "e")
graph.addEdge(from: "c", to: "d")
graph.addEdge(from: "c", to: "g")
graph.addEdge(from: "d", to: "c")
graph.addEdge(from: "d", to: "h")
graph.addEdge(from: "e", to: "a")
graph.addEdge(from: "e", to: "f")
graph.addEdge(from: "f", to: "g")
graph.addEdge(from: "g", to: "f")
graph.addEdge(from: "h", to: "d")
graph.addEdge(from: "f", to: "g")

// New graph for strongly connected components of graph
let scc: Graph<Set<String>> = Graph.stronglyConnectedComponents(graph)

// List of topologically sorted vertices
let array: [String] = try Graph.topologicalSort(graph)
```

## CocoaPods


```
pod "Gunma"
```

## Author

Soutaro Matsumoto <matsumoto@soutaro.com>
