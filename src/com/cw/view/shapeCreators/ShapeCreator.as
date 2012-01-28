package com.cw.view.shapeCreators{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * shape creator interface through createShape() Factory method
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 08/2011
	 * TODO:add more shape classes
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.errors.IllegalOperationError;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// ABSTRACT Class (should be subclassed and not instantiated)
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		////
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function draw(shapeType:uint, target:DisplayObjectContainer, shapesX:int, shapesY:int, shapeWidth:uint ,shapeHeight:uint):void{
			var shape:AbastractShapeCreator = this.createShape(shapeType);
			shape.createShape();
			shape.setWidthHeight(shapeWidth, shapeHeight);
			shape.setXYShapeLocation(shapesX, shapesY);
			target.addChild(shape as DisplayObject);
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// ABSTRACT Method error -
		// (the method should only be implemented in a subclass).
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		protected function createShape(shapeType:uint):AbastractShapeCreator{
			throw new IllegalOperationError('Abstract method: must be overridden in a subclass. ShapeCreator.createShape('+ shapeType+')');
			return null;
		}
	}
}