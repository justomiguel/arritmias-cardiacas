package com.jmv.framework.gaming.physics
{
    import Box2D.Collision.Shapes.b2Shape;
    import Box2D.Collision.b2AABB;
    import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.Joints.b2Joint;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	//import com.jmv.dragonrush.settings.Settings;

    import com.jmv.framework.core.managers.base.SManager;
    import com.jmv.framework.gaming.physics.listeners.PhContactListener;

    /**
     *
     * @author MatiX @ sismogames
     */
    public class PhEngineManager extends SManager
    {

        public static const MARK_TO_REMOVE:String = "REMOVE THIS ELEMENT ON SEFA MOMENT";

        public var world:b2World;
        public var enviroment:b2AABB;
        public var gravity:b2Vec2;
		
		public var debug:Boolean = false

        private var contactlistener:PhContactListener;

        private var _timestep:Number =   1 / 30; // 30 HZ for 30 fps
        private var _iterations:int = 10;

        public function PhEngineManager(enviroment:b2AABB = null, gravity:b2Vec2 = null){
            this.enviroment = enviroment;
            this.gravity = gravity;
        }

        override public function initialize():void
        {
            super.initialize();

            // setup the physics enviroment bounding box
            if (!this.enviroment)
            {
                enviroment = new b2AABB();
                enviroment.lowerBound.Set(-1000, -1000);
                enviroment.upperBound.Set(1000, 1000);
            }

            // setup gravity vector
            if (!this.gravity) {
                gravity = new b2Vec2(0, 10);
			}

            // setup main physics object: world
            world = new b2World(enviroment, gravity, true);

            // setup contact listener
            contactlistener = new PhContactListener();
            world.SetContactListener(contactlistener);
			
			_debugDrawSprite = new Sprite();
        }

        override public function dispose():void
        {
            super.dispose();
			
			contactlistener.removeAllContactListeners();
            contactlistener = null
			
			var b:b2Body = world.GetBodyList();
			while (b) {
				b.SetUserData(MARK_TO_REMOVE);
				b = b.GetNext();
			}
			safelyRemovePendants();
			
            enviroment = null;
            world = null;
            gravity = null;
			_debugDrawSprite = null;
        }

        /**
         * Engine loop:
         * Executes an step in the physics world and safely removes the marked-to-remove elements
         */
        public function update():void
        {
            try
            {
                world.Step(_timestep, _iterations);
                safelyRemovePendants();
            }
            catch (e:RangeError)
            {
                // BUG: m_bodyCount going negative sometimes -> solution: oppose m_bodycount when that happens :)
                world.m_bodyCount = -world.m_bodyCount;
            }
            catch (e:Error)
            {
                //trace("ERROR ON WORLD STEP FUNCTION");
					//trace(e.getStack//trace());
                    if (debug) throw e;
            }
        }

        private function safelyRemovePendants():void
        {
            // remove joints
            var joint:b2Joint = world.GetJointList();
            while (joint)
            {
                var next_j:b2Joint = joint.GetNext();
                if (joint.GetUserData() == MARK_TO_REMOVE)
                {
                    world.DestroyJoint(joint);
                }
                joint = next_j;
            }

            // remove shapes and bodies
            var b:b2Body = world.GetBodyList();
            while (b)
            {
                var next_b:b2Body = b.GetNext();
                if (b.GetUserData() == MARK_TO_REMOVE)
                {
                    world.DestroyBody(b);
				
                }
                else
                {
                    var shape:b2Shape = b.GetShapeList();
                    while (shape)
                    {
                        var next_s:b2Shape = shape.GetNext();
                        if (shape.GetUserData() == MARK_TO_REMOVE)
                        {
                            b.DestroyShape(shape);
                        }
                        shape = next_s;
                    }
                }
                b = next_b;
            }
        }

        // CONTACT EVENT HANDLING

        public function addContactListener(type:String, handler:Function):void
        {
            contactlistener.addContactListener(type, handler);
        }

        public function removeContactListener(type:String, handler:Function):void
        {
            contactlistener.removeContactListener(type, handler);
        }

        public function removeAllContactListeners():void
        {
            contactlistener.removeAllContactListeners();
        }

        public function toggleListeners(b:Boolean):void
        {
            contactlistener.toggleListeners(b);
        }
		
		// DEBUG DRAWING
		
		private var _debugDrawSprite:Sprite;
		private var _debugDraw:b2DebugDraw;
		
		public function startDD():void {
			_debugDraw = new b2DebugDraw();
			_debugDraw.m_sprite = _debugDrawSprite;
			_debugDrawSprite.alpha = 0.4;
			_debugDraw.m_drawScale = PhUnitConversionUtils.PIXELS_IN_METER;
			_debugDraw.m_alpha = 0.2;
			_debugDraw.m_lineThickness = 0;
			_debugDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit |
				//b2DebugDraw.e_coreShapeBit |
				//b2DebugDraw.e_aabbBit |
				//b2DebugDraw.e_obbBit |
				//b2DebugDraw.e_pairBit |
				b2DebugDraw.e_centerOfMassBit;
			world.SetDebugDraw(_debugDraw);
		}
		
		public function stopDD():void {
			_debugDrawSprite.graphics.clear();
			world.SetDebugDraw(null);
			_debugDraw = null;
		}
		
		public function get debugDrawSprite():Sprite { return _debugDrawSprite; }
		
		public function get timestep():Number { return _timestep; }
		
		public function set timestep(value:Number):void {
			_timestep = value;
		}
		
		public function get iterations():int { return _iterations; }
		
		public function set iterations(value:int):void {
			_iterations = value;
		}
    }

}

