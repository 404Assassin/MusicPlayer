package com.cw.view.shapeCreators{
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import flash.geom.Rectangle;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	internal class ShapeSquareRoundedFIlled extends AbastractShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ShapeSquareRoundedFIlled(){}
		/**
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 * scale9Grid x/y settings in the class AbastractShapeCreator should 
		 * equal or exceed rounded corner amounts.
		 * Make sure that the scale9Grid x/y settings in the class 
		 * AbastractShapeCreator total width/height do not exceed the shapes
		 * total width/height.
		 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		 */
		override internal function createShape():void {
			graphics.beginFill(0xFFFFFF);
			graphics.drawRoundRect(0,0,10,10,5);
		}
	}
}