import Foundation
import Quick
@testable import Gunma

class TopologicalSortTests: QuickSpec {
    override func spec() {
        var graph = Graph<Int>()
        
        graph.addVertex(2)
        graph.addVertex(3)
        graph.addVertex(5)
        graph.addVertex(7)
        graph.addVertex(8)
        graph.addVertex(9)
        graph.addVertex(10)
        graph.addVertex(11)
        
        graph.addEdge(from: 3, to: 8)
        graph.addEdge(from: 3, to: 10)
        graph.addEdge(from: 5, to: 11)
        graph.addEdge(from: 7, to: 8)
        graph.addEdge(from: 7, to: 11)
        graph.addEdge(from: 8, to: 9)
        graph.addEdge(from: 11, to: 2)
        graph.addEdge(from: 11, to: 9)
        graph.addEdge(from: 11, to: 10)
        
        func predecessorsTransitiveClosure(graph: Graph<Int>, i: Int) -> Set<Int> {
            var predecessors = graph.predecessors(to: i)
            var lastPredecessors: Set<Int>
            
            repeat {
                lastPredecessors = predecessors
                
                for j in predecessors {
                    predecessors = predecessors.union(graph.predecessors(to: j))
                }
                
            } while predecessors != lastPredecessors
            
            return predecessors
        }
        
        it("sorts topologically") {
            let sorted = try! Graph.topologicalSort(graph)
            
            for i in 0..<sorted.count-1 {
                let p = predecessorsTransitiveClosure(graph, i: sorted[i])
                
                for j in i+1..<sorted.count {
                    XCTAssert(!p.contains(sorted[j]))
                }
            }
        }
        
        it("throws an error if the graph has a cycle") {
            var g = Graph<Int>()
            
            g.addVertex(1)
            g.addVertex(2)
            
            g.addEdge(from: 1, to: 2)
            g.addEdge(from: 2, to: 1)
            
            do {
                try Graph.topologicalSort(g)
                XCTAssert(false, "should not be reached...")
            } catch TopologicalSortError.Cyclic {
                XCTAssert(true, "error is expected")
            } catch _ {
                XCTAssert(false, "should not be reached...")
            }
        }
    }
}