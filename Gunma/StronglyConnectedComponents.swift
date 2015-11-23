import Foundation

public extension Graph {
    /**
     Returns new graph which vertices are strongly connected components of given graph.
     */
    public static func stronglyConnectedComponents(graph: Graph<V>) -> Graph<Set<V>> {
        var successors: [V: Set<V>] = [:]
        
        graph.eachEdge { (from, to) in
            if var vertices = successors[from] {
                vertices.insert(to)
                successors[from] = vertices
            } else {
                successors[from] = Set(arrayLiteral: to)
            }
        }
        
        var index: UInt = 0
        var indexes: [V: UInt] = [:]
        var lowlinks: [V: UInt] = [:]
        var onStack: [V: Bool] = [:]
        var stack: [V] = []
        
        var components: [V: Set<V>] = [:]
        
        graph.eachVertex { v in
            if indexes[v] == nil {
                self.stronglyConnect(graph, vertex: v, index: &index, indexes: &indexes, lowlinks: &lowlinks, onStack: &onStack, stack: &stack, successors: &successors) { component in
                    for v in component {
                        components[v] = component
                    }
                }
            }
        }
        
        var edges: Set<Edge<Set<V>>> = Set()
        
        graph.eachEdge {
            let from = components[$0]!
            let to = components[$1]!
            if from != to {
                edges.insert(Edge(start: from, end: to))
            }
        }
        
        return Graph<Set<V>>(vertices: Set(components.values), edges: edges)
    }
    
    static func stronglyConnect<V>(graph: Graph<V>, vertex: V, inout index: UInt, inout indexes: [V: UInt], inout lowlinks: [V: UInt], inout onStack: [V: Bool], inout stack: [V], inout successors: [V: Set<V>], callback: (Set<V>) -> ()) {
        indexes[vertex] = index
        lowlinks[vertex] = index
        index += 1
        stack.append(vertex)
        onStack[vertex] = true
        
        for w in successors[vertex]! {
            if indexes[w] == nil {
                self.stronglyConnect(graph, vertex: w, index: &index, indexes: &indexes, lowlinks: &lowlinks, onStack: &onStack, stack: &stack, successors: &successors, callback: callback)
                lowlinks[vertex] = min(lowlinks[vertex]!, lowlinks[w]!)
            } else if onStack[w] == true {
                lowlinks[vertex] = min(lowlinks[vertex]!, indexes[w]!)
            }
        }
        
        if lowlinks[vertex]! == indexes[vertex]! {
            var component = Set<V>()
            var w: V
            
            repeat {
                w = stack.popLast()!
                onStack[w] = false
                component.insert(w)
            } while w != vertex
            
            callback(component)
        }
    }
}