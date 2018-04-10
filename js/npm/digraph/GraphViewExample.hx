package js.npm.digraph;

import haxe.DynamicAccess;
import haxe.Json;

import react.ReactComponent;
import react.ReactMacro.jsx;

import js.npm.digraph.DiGraph;
import js.npm.digraph.DiGraph.DiGraphConstants.*;
import js.npm.digraph.GraphViewImplementation;

using Lambda;

class GraphViewExample
	extends ReactComponentOfState<GraphComponentState>
{
	// These keys are arbitrary (but must match the config)
	// However, GraphView renders text differently for empty types
	// so this has to be passed in if that behavior is desired.
	static var EMPTY_TYPE = "empty"; // Empty node type
	static var SPECIAL_TYPE = "special";
	static var SPECIAL_CHILD_SUBTYPE = "specialChild";
	static var EMPTY_EDGE_TYPE = "emptyEdge";
	static var SPECIAL_EDGE_TYPE = "specialEdge";

	public function new(props)
	{
		super(props);
		this.state = EXAMPLE_STATE;
	}

	override public function render()
	{
		var ops :GraphOperations = {
			getViewNode: this.getViewNode,
			onSelectNode: this.onSelectNode,
			onCreateNode: this.onCreateNode,
			onUpdateNode: this.onUpdateNode,
			onDeleteNode: this.onDeleteNode,
			onSelectEdge: this.onSelectEdge,
			onCreateEdge: this.onCreateEdge,
			onSwapEdge: this.onSwapEdge,
			onDeleteEdge: this.onDeleteEdge,
		};
		var config :GraphConfig = EXAMPLE_CONFIG;
		var nodeKey = NODE_KEY;
		var emptyType = EMPTY_TYPE;
		var state :GraphComponentState = this.state;

		var styles = {
		  graph: {
		    height: '100%',
		    width: '100%'
		  }
		};
		return jsx('
			<div id="graph" style={styles.graph}>
				<GraphViewImplementation
					nodeKey={nodeKey}
					emptyType={emptyType}
					ops={ops}
					config={config}
					state={state}
				/>
			</div>
		');
	}

	// Given a nodeKey, return the corresponding node
	public function getViewNode(nodeKey)
	{
		var searchNode :GraphStateNode = cast {id:nodeKey};
		var i = this.getNodeIndex(searchNode);
		return this.state.graph.nodes[i];
	}

	  /*
	   * Handlers/Interaction
	   */

	// Called by 'drag' handler, etc..
	// to sync updates from D3 with the graph
	public function onUpdateNode(viewNode)
	{
		var graph = this.state.graph;
		var i = this.getNodeIndex(viewNode);

		graph.nodes[i] = viewNode;
		this.setState({graph: graph});
	}


	// Node 'mouseUp' handler
	public function onSelectNode(viewNode)
	{
		// Deselect events will send Null viewNode
		if (viewNode != null) {
			this.setState({selected: viewNode});
		} else{
			this.setState({selected: {}});
		}
	}

	// Edge 'mouseUp' handler
	public function onSelectEdge(viewEdge)
	{
		this.setState({selected: viewEdge});
	}

	// Updates the graph with a new node
	public function onCreateNode(x :Int, y :Int)
	{
		trace('onCreateNode');
		var graph = this.state.graph;

		// This is just an example - any sort of logic
		// could be used here to determine node type
		// There is also support for subtypes. (see 'sample' above)
		// The subtype geometry will underlay the 'type' geometry for a node
		var type = Math.random() < 0.25 ? SPECIAL_TYPE : EMPTY_TYPE;

		var viewNode :GraphStateNode = {
			id: this.state.graph.nodes.length + 1,
			title: '',
			type: type,
			x: x,
			y: y
		}

		graph.nodes.push(viewNode);
		this.setState({graph: graph});
	}

	// Deletes a node from the graph
	public function onDeleteNode(viewNode :GraphStateNode)
	{
		var graph = this.state.graph;
		var i = this.getNodeIndex(viewNode);
		graph.nodes.splice(i, 1);

		// Delete any connected edges
		var newEdges = graph.edges.filter(function(edge) {
			return edge.source != viewNode.id &&
				edge.target != viewNode.id;
		});

		graph.edges = newEdges;

		this.setState({graph: graph, selected: {}});
	}

	// Creates a new node between two edges
	public function onCreateEdge(sourceViewNode :GraphStateNode, targetViewNode :GraphStateNode)
	{
		trace('onCreateEdge');
		var graph = this.state.graph;

		// This is just an example - any sort of logic
		// could be used here to determine edge type
		var type = sourceViewNode.type == SPECIAL_TYPE ? SPECIAL_EDGE_TYPE : EMPTY_EDGE_TYPE;

		var viewEdge = {
			source: sourceViewNode.id,//[NODE_KEY],
			target: targetViewNode.id,//[NODE_KEY],
			type: type
		};
		graph.edges.push(viewEdge);
		this.setState({graph: graph});
	}

	public function onSwapEdge(sourceViewNode :GraphStateNode, targetViewNode :GraphStateNode, viewEdge :GraphStateEdge)
	{
		var graph = this.state.graph;
	    var i = this.getEdgeIndex(viewEdge);
	    var edge = Json.parse(Json.stringify(graph.edges[i]));

	    edge.source = sourceViewNode.id;//[NODE_KEY];
	    edge.target = targetViewNode.id;//[NODE_KEY];
	    graph.edges[i] = edge;

	    this.setState({graph: graph});
	}

	public function onDeleteEdge(edge :GraphStateEdge)
	{
		var graph = this.state.graph;
	    var i = this.getEdgeIndex(edge);
	    graph.edges.splice(i, 1);
	    this.setState({graph: graph, selected: {}});
	}

	// Helper to find the index of a given node
	function getNodeIndex(searchNode :GraphStateNode) :Int
	{
		var i = 0;
		while(i < this.state.graph.nodes.length) {
			var node = this.state.graph.nodes[i];
			if (node.id == searchNode.id) {
				return i;
			}
			i++;
		}
		return -1;
	}

	// Helper to find the index of a given edge
	function getEdgeIndex(searchEdge :GraphStateEdge) :Int
	{
		var i = 0;
		while(i < this.state.graph.edges.length) {
			var edge = this.state.graph.edges[i];
			if (edge.source == searchEdge.source &&
				edge.target == searchEdge.target) {
				return i;
			}
			i++;
		}
		return -1;
	}

	static var EXAMPLE_STATE :GraphComponentState = {
	  "graph": {
		  	"nodes": [
		    {
		      "id": 1,
		      "title": "Node A",
		      "x": 258.3976135253906,
		      "y": 331.9783248901367,
		      "type": "empty"
		    },
		    {
		      "id": 2,
		      "title": "Node B",
		      "x": 593.9393920898438,
		      "y": 260.6060791015625,
		      "type": "empty"
		    },
		    {
		      "id": 3,
		      "title": "Node C",
		      "x": 237.5757598876953,
		      "y": 61.81818389892578,
		      "type": "empty"
		    },
		    {
		      "id": 4,
		      "title": "Node C",
		      "x": 600.5757598876953,
		      "y": 600.81818389892578,
		      "type": "empty"
		    }
		  ],
		  "edges": [
		    {
		      "source": 1,
		      "target": 2,
		      "type": "emptyEdge"
		    },
		    {
		      "source": 2,
		      "target": 4,
		      "type": "emptyEdge"
		    }
		  ]
		},
		"selected": null
	};

	static var EmptyShape = jsx('
  <symbol viewBox="0 0 100 100" id="empty" key="0">
    <circle cx="50" cy="50" r="45"></circle>
  </symbol>
');

	static var SpecialShape = jsx('
  <symbol viewBox="0 0 100 100" id="special" key="1">
    <rect transform="translate(50) rotate(45)" width="70" height="70"></rect>
  </symbol>
');

	static var SpecialChildShape = jsx('
  <symbol viewBox="0 0 100 100" id="specialChild" key="0">
    <rect x="2.5" y="0" width="95" height="97.5" fill="rgba(30, 144, 255, 0.12)"></rect>
  </symbol>');

	static var EmptyEdgeShape = jsx('
  <symbol viewBox="0 0 50 50" id="emptyEdge" key="0">
    <circle cx="25" cy="25" r="8" fill="currentColor"> </circle>
  </symbol>
');

	static var SpecialEdgeShape = jsx('
  <symbol viewBox="0 0 50 50" id="specialEdge" key="1">
    <rect transform="rotate(45)"  x="25" y="-4.5" width="15" height="15" fill="currentColor"></rect>
  </symbol>
');


// 	static var EmptyShape = jsx('
//   <div/>
// ');

// 	static var SpecialShape = jsx('
//   <div/>
// ');

// 	static var SpecialChildShape = jsx('
//   <div/>
//   ');

// 	static var EmptyEdgeShape = jsx('
//   <div/>
// ');

// 	static var SpecialEdgeShape = jsx('
//   <div/>
// ');



	static var EXAMPLE_CONFIG :GraphConfig =
	{
	  "NodeTypes": {
	    "empty": {
	      "typeText": "None",
	      "shapeId": "#empty",
	      "shape": EmptyShape
	    },
	    "special": {
	      "typeText": "Special",
	      "shapeId": "#special",
	      "shape": SpecialShape
	    }
	  },
	  "NodeSubtypes": {
	    "specialChild": {
	      "shapeId": "#specialChild",
	      "shape": SpecialChildShape
	    }
	  },
	  "EdgeTypes": {
	    "emptyEdge": {
	      "shapeId": "#emptyEdge",
	      "shape": EmptyEdgeShape
	    },
	    "specialEdge": {
	      "shapeId": "#specialEdge",
	      "shape": SpecialEdgeShape
	    }
	  }
	};
}


