package com.jmv.framework.gaming.physics
{
    import Box2D.Collision.Shapes.b2CircleDef;
    import Box2D.Collision.Shapes.b2PolygonDef;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2BodyDef;

    import flash.geom.Point;
    import flash.geom.Rectangle;

    /**
     * Provides handy pixel-meters, radians-degrees, point-b2vec2 unit conversion functions
     * and easy shape definitons creation to use with the engine manager
     *
     * @author MatiX @ sismogames
     */
    public class PhUnitConversionUtils
    {

	
        private static var _PIXELS_IN_METER:int = 30;

        public function PhUnitConversionUtils()
        {
        }

        /**
         * Converts a given amount of pixels in meters
         */
        public static function pixelsToMeters(px:Number):Number
        {
            return px / PIXELS_IN_METER;
        }

        /**
         * Converts a given amount of meters in pixels
         */
        public static function metersToPixels(mts:Number):Number
        {
            return mts * PIXELS_IN_METER;
        }

        /**
         * Converts an angle given in  radians to degrees
         */
        public static function radiansToDegrees(rad:Number):Number
        {
            return rad * (180 / Math.PI);
        }

        /**
         * Converts an angle given in  degrees to radians
         */
        public static function degreesToRadians(deg:Number):Number
        {
            return deg * (Math.PI / 180);
        }

        /**
         * Converts a flash.geom.Point given in pixels to
         * a Box2D.Common.Math.b2Vec2 in meters.
         */
        public static function pointTob2vec2(point:Point):b2Vec2
        {
            var b2x:Number = pixelsToMeters(point.x);
            var b2y:Number = pixelsToMeters(point.y);

            return new b2Vec2(b2x, b2y);
        }

        /**
         * Converts a Box2D.Common.Math.b2Vec2 given in meters to
         * a flash.geom.Point in pixels.
         */
        public static function b2vec2ToPoint(b2vec:b2Vec2):Point
        {
            var px:Number = metersToPixels(b2vec.x);
            var py:Number = metersToPixels(b2vec.y);

            return new Point(px, py);
        }

        /**
         * Converts a flash.geom.Rectangle given in pixels to
         * a Box2D.Collision.Shapes.b2PolygonDefin meters.
         * Coordinate center will be considered to be in the upper left corner of the rectangle
         */
        public static function rectangleToPolygonDef(rec:Rectangle):b2PolygonDef
        {
            var polyDef:b2PolygonDef = new b2PolygonDef();
            polyDef.vertexCount = 4;
            polyDef.vertices[0] = pointTob2vec2(new Point(rec.x, rec.y));
            polyDef.vertices[1] = pointTob2vec2(new Point(rec.x + rec.width, rec.y));
            polyDef.vertices[2] = pointTob2vec2(new Point(rec.x + rec.width, rec.y + rec.height));
            polyDef.vertices[3] = pointTob2vec2(new Point(rec.x, rec.y + rec.height));

            return polyDef;
        }

        /**
         * Creates an b2PolygonDef that represents an rectangle centered in a given point
         *
         * @param halfWidth:Number, a half of the final width the rectangle is supossed to be, in pixels
         * @param halfHeight:Number, a half of the final height the rectangle is supossed to be, in pixels
         * @param center:Point, the center of the rectangle, relative to the mass center of the body where it will be created, in pixels
         * @param angle:Number, an optional rotation angle for the rectangle, rotation pivot will be the given center, in degrees
         *
         */
        public static function centeredRectangleToPolygonDef(halfWidth:Number, halfHeight:Number, center:Point = null, angle:Number = 0):b2PolygonDef
        {
            var polyDef:b2PolygonDef = new b2PolygonDef();
            var hx:Number = PhUnitConversionUtils.pixelsToMeters(halfWidth);
            var hy:Number = PhUnitConversionUtils.pixelsToMeters(halfHeight);
            var angleR:Number = PhUnitConversionUtils.degreesToRadians(angle);
			var centerp:b2Vec2 = (center)? PhUnitConversionUtils.pointTob2vec2(center):new b2Vec2(0, 0);
            polyDef.SetAsOrientedBox(hx, hy, centerp, angleR);
			
            return polyDef;
        }
		
		public static function twoPointsToRectangle(p1:Point, p2:Point, thickness:Number):b2PolygonDef 
		{
			var polyDef:b2PolygonDef = new b2PolygonDef();
			var distance:Number = Point.distance(p1, p2);
			var dx:Number = p2.x - p1.x;
			var angle:Number = Math.acos(dx / distance);
			var center:Point = Point.interpolate(p1, p2, 0.5);
			polyDef.SetAsOrientedBox(pixelsToMeters(distance / 2), pixelsToMeters(thickness / 2), pointTob2vec2(center), angle);
			
			return polyDef;
		}
		
        /**
         * Creates an b2PolygonDef that represents an polygon defined by a collection of points that represent its vertices.
         *
         * @param pointList:Array an collection of Point that represent the vertices of the polygon
         * (NOTE: b2PolygonDef only creates CONVEX polygons, if the point list defines a CONCAVE polygon it might not work as expected)
         *
         */
        public static function pointListToPolygonDef(pointList:Array):b2PolygonDef
        {
            var polyDef:b2PolygonDef = new b2PolygonDef();
            polyDef.vertexCount = pointList.length;
            for (var i:int = 0; i < pointList.length; i++)
            {
                var point:Point = pointList[i];
                var b2Vec:b2Vec2 = pointTob2vec2(point);
                polyDef.vertices[i] = b2Vec;
            }

            return polyDef;
        }

        /**
         * Creates an b2CircleDef that represents a circle given by a radius and a position
         *
         * @param radiusInPX:Number, the radius of the circle, in pixels
         * @param position:Point, the center position of the circle, relative to the mass center of the body where it will be created, in pixels
         *
         */
        public static function circleTob2CircleDef(radiusInPX:Number, position:Point = null):b2CircleDef
        {
            var circleDef:b2CircleDef = new b2CircleDef();
            circleDef.radius = pixelsToMeters(radiusInPX);
            if (position)
                circleDef.localPosition.Set(pixelsToMeters(position.x), pixelsToMeters(position.y));

            return circleDef;
        }

        /**
         * Creates an b2BodyDef in the given coordinates relative to the b2World coordinate system where the bdy will be created.
         *
         * @param x:Number, the x coordinate of the body, in pixels
         * @param y:Number, the y coordinate of the body, in pixels
         *
         */
        public static function createBodyDefAtPoint(x:Number, y:Number, props:Object = null):b2BodyDef
        {
            var bodyDef:b2BodyDef = new b2BodyDef();
            var x_mts:Number = pixelsToMeters(x);
            var y_mts:Number = pixelsToMeters(y);
            bodyDef.position.Set(x_mts, y_mts);
			
			if (props) {
				for (var name:String in props) {
					if (Object(bodyDef).hasOwnProperty(name)) bodyDef[name] = props[name];
				}
			}
			
            return bodyDef;
        }
		
		static public function get PIXELS_IN_METER():int { return _PIXELS_IN_METER; }
		
		static public function set PIXELS_IN_METER(value:int):void 
		{
			_PIXELS_IN_METER = value;
		}
    }

}

