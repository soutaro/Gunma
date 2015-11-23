import Foundation

enum TopologicalSortError: ErrorType {
    case Cyclic
}

public extension Graph {
    /**
     Returns array of vertex where it is topologically sorted.
     
     - Throws: `TopologicalSortError.Cyclic` if the graph contains a cycle.
     */
    public static func topologicalSort(graph: Graph<V>) throws -> [V] {
        var predecessors = graph.predecessors()
        var successors = graph.successors()
        
        var result: [V] = []
        
        var s: Set<V> = Set()
        graph.eachVertex {
            if predecessors[$0] == nil {
                s.insert($0)
            }
        }
        
        while !s.isEmpty {
            let n = s.first!
            s.remove(n)
            result.append(n)
            
            if let ss = successors[n] {
                for m in ss {
                    self.removeEdge(n, to: m, predecessors: &predecessors, successors: &successors)
                    if (predecessors[m] ?? Set()).isEmpty {
                        s.insert(m)
                    }
                }
            }
        }
        
        if predecessors.isEmpty && successors.isEmpty {
            return result
        } else {
            throw TopologicalSortError.Cyclic
        }
    }
    
    static func removeEdge<V>(from: V, to: V, inout predecessors: [V: Set<V>], inout successors: [V: Set<V>]) {
        if var ps = predecessors[to] {
            ps.remove(from)
            if ps.isEmpty {
                predecessors.removeAtIndex(predecessors.indexForKey(to)!)
            } else {
                predecessors[to] = ps
            }
        }
        
        if var ss = successors[from] {
            ss.remove(to)
            if ss.isEmpty {
                successors.removeAtIndex(successors.indexForKey(from)!)
            } else {
                successors[from] = ss
            }
        }
    }
}