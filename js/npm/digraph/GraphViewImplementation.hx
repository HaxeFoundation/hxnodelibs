package js.npm.digraph;

import haxe.DynamicAccess;

import react.ReactComponent;
import react.ReactMacro.jsx;

import js.npm.digraph.DiGraph;
import js.npm.digraph.DiGraph.DiGraphConstants.*;
import js.npm.digraph.GraphView;


class GraphViewImplementation
	extends ReactComponentOfProps<GraphComponentProps>
{
	public function new(props)
	{
		super(props);
	}

	override public function render()
	{
		var nodeKey = this.props.nodeKey;
		var emptyType = this.props.emptyType;
		var config = this.props.config;
		var ops = this.props.ops;

		var NodeTypes = config != null ? config.NodeTypes : null;
		var NodeSubtypes = config != null ? config.NodeSubtypes : null;
		var EdgeTypes = config != null ? config.EdgeTypes : null;

		var graphState :GraphComponentState = this.props.state != null ? this.props.state : {};

		var nodes = graphState.graph != null && graphState.graph.nodes != null ? graphState.graph.nodes : [];
		var edges = graphState.graph != null && graphState.graph.edges != null ? graphState.graph.edges : [];
		var selected = graphState.selected != null ? graphState.selected : {};

		return jsx('
			<GraphView ref="GraphView"
				nodeKey={nodeKey}
				emptyType={emptyType}
				nodes={nodes}
				edges={edges}
				selected={selected}
				nodeTypes={NodeTypes}
				nodeSubtypes={NodeSubtypes}
				edgeTypes={EdgeTypes}
				getViewNode={ops.getViewNode}
				onSelectNode={ops.onSelectNode}
				onCreateNode={ops.onCreateNode}
				onUpdateNode={ops.onUpdateNode}
				onDeleteNode={ops.onDeleteNode}
				onSelectEdge={ops.onSelectEdge}
				onCreateEdge={ops.onCreateEdge}
				onSwapEdge={ops.onSwapEdge}
				onDeleteEdge={ops.onDeleteEdge}
			/>
		');
	}
}