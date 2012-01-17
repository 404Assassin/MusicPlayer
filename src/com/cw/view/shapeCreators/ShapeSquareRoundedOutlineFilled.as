package com.cw.view.shapeCreators{
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	internal class ShapeSquareRoundedOutlineFilled extends AbastractShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ShapeSquareRoundedOutlineFilled(){}
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
			graphics.lineStyle(1,0x000000);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRoundRect(0,0,9,9,4);
			graphics.endFill();
		}
	}
}