package js.npm.digraph;

import haxe.DynamicAccess;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef NodeType = {
	@:optional var typeText :String;
	var shapeId :String;
	var shape :Dynamic;
}

typedef EdgeType = {
	shapeId:String,
	shape: Dynamic
}

typedef GraphConfig = {
	var NodeTypes:DynamicAccess<NodeType>;
	var EdgeTypes:DynamicAccess<EdgeType>;
	@:optional var NodeSubtypes:DynamicAccess<NodeType>;
}

typedef GraphOperations  = {
	function getViewNode(nodeKey :String) :GraphStateNode;
	function onSelectNode(node :GraphStateNode) :Void;
	function onCreateNode(x :Int, y :Int) :Void;
	function onUpdateNode(node :GraphStateNode) :Void;
	function onDeleteNode(node :GraphStateNode) :Void;
	function onSelectEdge(edge :GraphStateEdge) :Void;
	function onCreateEdge(sourceViewNode :GraphStateNode, targetViewNode :GraphStateNode) :Void;
	function onSwapEdge(sourceViewNode :GraphStateNode, targetViewNode :GraphStateNode, viewEdge :GraphStateEdge) :Void;
	function onDeleteEdge(edge :GraphStateEdge) :Void;
}

typedef GraphStateNode = {
	var id :Int;
	var title :String;
	var x :Float;
	var y :Float;
	var type :String;
}

typedef GraphStateEdge = {
	var source :Int;
	var target :Int;
	var type :String;
}

typedef GraphState = {
	var nodes :Array<GraphStateNode>;
	var edges :Array<GraphStateEdge>;
}

typedef GraphComponentState = {
	@:optional var graph :GraphState;
	@:optional var selected :Dynamic;
}

typedef GraphComponentProps = {
	var nodeKey :String;
	var emptyType :String;
	var config :GraphConfig;
	var ops :GraphOperations;
	@:optional var state :GraphComponentState;
}

class DiGraphConstants
{
	inline public static var NODE_KEY = 'id';
	inline public static var EMPTY_TYPE = 'empty';

}