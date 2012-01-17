package com.cw.view.shapeCreators{
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	internal class ShapeSquareOutlineFilled extends AbastractShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ShapeSquareOutlineFilled(){}
		override internal function createShape():void {
			// define the line style 
			graphics.lineStyle(1,0x000000); 
			// define the fill 
			graphics.beginFill(0xFFFFFF) 
			// set the starting point for the line 
			graphics.moveTo(0,0); 
			// move the line through a series of coordinates 
			graphics.lineTo(0,100); 
			graphics.lineTo(100,100); 
			graphics.lineTo(100,0);
		}
	}
}