package com.cw.view.shapeCreators{
	/**
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * Shape creator abstract interface through createShape() Factory method. 
	 * This is a ABSTRACT ClASS and should be subclassed and not instantiated 
	 * directly.
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 08/2011
	 * TODO; add more shape classes 
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// ABSTRACT Class (should be subclassed and not instantiated)
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	internal class AbastractShapeCreator extends Sprite{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// createShape() is a ABSTRACT Method (should be implemented in subclassed)
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		internal function createShape():void {
		}
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * scale9Grid x/y settings should equal or exceed rounded corner 
		 * amounts.
		 * also make sure that the total width/height do not exceed the shapes
		 * width/height.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		internal function setWidthHeight(shapeWidth:Number, shapeHeight:Number):void{
			this.width = shapeWidth;
			this.height = shapeHeight;
			this.scale9Grid = new Rectangle(5, 5, 1, 1);
		}
		internal function setXYShapeLocation(shapesX:Number, shapesY:Number):void{
			this.x = shapesX;
			this.y = shapesY;
		}
	}
}