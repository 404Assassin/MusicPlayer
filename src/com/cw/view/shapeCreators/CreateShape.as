package com.cw.view.shapeCreators{
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * Shape creator abstract interface through createShape() Factory method. 
	 * This is a ABSTRACT ClASS and should be subclassed and not instantiated 
	 * directly.
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 08/2011
	 * TODO; add more shape classes 
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// ABSTRACT Class (should be subclassed and not instantiated)
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class CreateShape extends ShapeCreator{
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public static constants
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public static const CIRCLE_OUTLINE:uint = 0;
		public static const CIRCLE_FILLED:uint = 1;
		public static const SQUARE_OUTLINE:uint = 2;
		public static const SQUARE_FILLED:uint = 3;
		public static const SQUARE_OUTLINE_FILLED:uint = 4;
		public static const CIRCLE_OUTLINE_FILLED:uint = 5;
		public static const SQUARE_ROUNDED_OUTLINE_FILLED:uint = 6;
		public static const SQUARE_ROUNDED_FILLED:uint = 7;
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// ShapeCreator's createShape() override logic
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		override protected function createShape(shapeType:uint):AbastractShapeCreator{
			if(shapeType == CIRCLE_OUTLINE){
				return new ShapeCircleOutline();
			}else if(shapeType == CIRCLE_FILLED){
				return new ShapeCircleFilled();
			}else if(shapeType == SQUARE_OUTLINE){
				return new ShapeSquareOutline();
			}else if(shapeType == SQUARE_FILLED){
				return new ShapeSquareFilled();
			}else if(shapeType == SQUARE_OUTLINE_FILLED){
				return new ShapeSquareOutlineFilled();
			}else if(shapeType == CIRCLE_OUTLINE_FILLED){
				return new ShapeCircleOutlineFilled();
			}else if(shapeType == SQUARE_ROUNDED_OUTLINE_FILLED){
				return new ShapeSquareRoundedOutlineFilled();
			}else if(shapeType == SQUARE_ROUNDED_FILLED){
				return new ShapeSquareRoundedFIlled();
			}else{
				throw new Error('Invalid shape');
			}
		}
	}
}