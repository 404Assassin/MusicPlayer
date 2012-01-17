package com.cw.view.shapeCreators{
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	internal class ShapeCircleOutlineFilled extends AbastractShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ShapeCircleOutlineFilled(){}
		override internal function createShape():void {
		graphics.lineStyle(1,0x000000);
		graphics.beginFill(0xFFFFFF);
		graphics.drawCircle(0, 0, 10);
		graphics.endFill();
		}
	}
}