import Foundation

struct Edge<V: Hashable>: Hashable {
    let start: V
    let end: V
    
    var hashValue: Int {
        return self.start.hashValue ^ self.end.hashValue
    }
}

func ==<V: Hashable>(e1: Edge<V>, e2: Edge<V>) -> Bool {
    return e1.start == e2.start && e1.end == e2.end
}

public struct Graph<V: Hashable> {
    typealias E = Edge<V>
    
    var vertices: Set<V>
    var edges: Set<E>
    
    public init() {
        self.vertices = Set<V>()
        self.edges = Set<E>()
    }
    
    internal init(vertices: Set<V>, edges: Set<E>) {
        self.vertices = vertices
        self.edges = edges
    }
    
    /**
     Add new vertex to the graph.
     */
    mutating public func addVertex(vertex: V) {
        self.vertices.insert(vertex)
    }
    
    /**
     Remove a vertex from the graph.
     
     The resulting graph will be invalid because this method does not maintain edges at all.
     */
    mutating public func removeVertex(vertex: V) {
        self.vertices.remove(vertex)
    }
    
    /**
     Returns true if given vertex is included in the graph.
     */
    public func hasVertex(vertex: V) -> Bool {
        return self.vertices.contains(vertex)
    }
    
    /**
     Add new edge to the graph.
     
     The resulting graph will be invalid.
     This method does not check the validity of vertices specified.
     */
    mutating public func addEdge(from from: V, to: V) {
        self.edges.insert(Edge<V>(start: from, end: to))
    }
    
    /**
     Remove edge from the graph.
     */
    mutating public func removeEdge(from from: V, to: V) {
        self.edges.remove(Edge<V>(start: from, end: to))
    }
    
    /**
     Returns true if given edge is included in the graph.
     */
    public func hasEdge(from from: V, to: V) -> Bool {
        return self.edges.contains(Edge<V>(start: from, end: to))
    }
    
    /**
     Returns true if all edges has source and destination included in the graph.
     */
    public var isValid: Bool {
        return self.allEdge { self.hasVertex($0) && self.hasVertex($1) }
    }
    
    public func eachVertex(proc: (V) -> ()) {
        for v in self.vertices {
            proc(v)
        }
    }
    
    public func allVertex(test: (V) -> Bool) -> Bool {
        for v in self.vertices {
            if !test(v) {
                return false
            }
        }
        
        return true
    }
    
    public func anyVertex(test: (V) -> Bool) -> Bool {
        for v in self.vertices {
            if test(v) {
                return true
            }
        }
        
        return false
    }
    
    public func eachEdge(proc: (V, V) -> ()) {
        for e in self.edges {
            proc(e.start, e.end)
        }
    }
    
    public func allEdge(test: (V, V) -> Bool) -> Bool {
        for e in self.edges {
            if !test(e.start, e.end) {
                return false
            }
        }
        
        return true;
    }
    
    public func anyEdge(test: (V, V) -> Bool) -> Bool {
        for e in self.edges {
            if test(e.start, e.end) {
                return true
            }
        }
        
        return false
    }
    
    /**
     Returns mapping of all successors.
     The result will not contain vertices there is no successor from.
     */
    public func successors() -> [V: Set<V>] {
        var result: [V: Set<V>] = [:]
        
        self.eachEdge {
            if var ss = result[$0] {
                ss.insert($1)
                result[$0] = ss
            } else {
                result[$0] = Set(arrayLiteral: $1)
            }
        }
        
        return result
    }
    
    /**
     Returns set of vertex where there is a edge from given vertex to it.
     */
    public func successors(from vertex: V) -> Set<V> {
        return self.successors()[vertex] ?? Set()
    }
    
    /**
     Returns mapping of all predecessors.
     The result will not contain vertexes there is no predecessors to.
     */
    public func predecessors() -> [V: Set<V>] {
        var result: [V: Set<V>] = [:]
        
        self.eachEdge {
            if var ps = result[$1] {
                ps.insert($0)
                result[$1] = ps
            } else {
                result[$1] = Set(arrayLiteral: $0)
            }
        }
        
        return result
    }
    
    /**
     Returns set of vertex where there is a edge to given vertex from it.
     */
    public func predecessors(to vertex: V) -> Set<V> {
        return self.predecessors()[vertex] ?? Set()
    }
}
