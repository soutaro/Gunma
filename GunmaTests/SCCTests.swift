import Foundation
import Quick
@testable import Gunma

class SCCTests: QuickSpec {
    override func spec() {
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
        
        it("calculates strongly connected components") {
            let scc = Graph.stronglyConnectedComponents(graph)
            
            let c1 = Set(arrayLiteral: "a", "b", "e")
            let c2 = Set(arrayLiteral: "c", "d", "h")
            let c3 = Set(arrayLiteral: "f", "g")
            
            XCTAssertEqual(Set(arrayLiteral: c1, c2, c3), scc.vertices)
            XCTAssertEqual(Set(arrayLiteral: Edge(start: c1, end: c2), Edge(start: c1, end: c3), Edge(start: c2, end: c3)), scc.edges)
        }
    }
}