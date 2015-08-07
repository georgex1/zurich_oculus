﻿Shader "3y3net/GlowHiddenNormalMobile"
{    
    Properties {
		_Color ("Main Color", Color) = (.5,.5,.5,1)
		_GlowColor ("Glow Color", Color) = (0,0,0,1)
		_Outline ("Outline width", Range (0.02, 0.25)) = .005
		_Opacity ("Glow Opacity", Range (0.5, 2.0)) = 1.0
		_MainTex ("Base (RGB)", 2D) = "white" { }
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_ScaleTrick ("Scale factor", Color) = (1,1,1,1)
	}
    SubShader
    {
        //Tags { "Queue" = "Transparent" "LightMode" = "ForwardBase"}
        
        Pass {            
	    	//Cull Off
		        ZWrite Off Blend SrcAlpha OneMinusSrcAlpha
	        GLSLPROGRAM                          
	        #ifdef VERTEX  
	        uniform float _Outline;
			uniform vec4 _GlowColor;
			uniform vec4 _ScaleTrick;
			uniform mat4 _World2Object; 
	        void main()
	        {  
	        	float _Oclusion=0.2;
	        	gl_Position = gl_ModelViewProjectionMatrix * (gl_Vertex+(_Outline*_Oclusion*vec4(gl_Normal, 0.0))/5.0);
	        }
	        #endif  
	        #ifdef FRAGMENT
	        uniform vec4 _GlowColor;
	        uniform float _Opacity;
	        void main()
	        {          
	           gl_FragColor = vec4(_GlowColor.r,_GlowColor.g,_GlowColor.b, _Opacity/10.0);
	        }
	        #endif                          
	        ENDGLSL        
	    }
	    
	    Pass {            
	    	//Cull Off
		        ZWrite Off Blend SrcAlpha OneMinusSrcAlpha
	        GLSLPROGRAM                          
	        #ifdef VERTEX  
	        uniform float _Outline;
			uniform vec4 _GlowColor;
	        uniform vec4 _ScaleTrick;
	        uniform mat4 _World2Object; 
	        void main()
	        {  
	        	float _Oclusion=0.4;
	        	gl_Position = gl_ModelViewProjectionMatrix * (gl_Vertex+(_Outline*_Oclusion*vec4(gl_Normal, 0.0))/5.0);
	        }
	        #endif  
	        #ifdef FRAGMENT
	        uniform vec4 _GlowColor;
	        uniform float _Opacity;
	        void main()
	        {          
	           gl_FragColor = vec4(_GlowColor.r,_GlowColor.g,_GlowColor.b, _Opacity/10.0);
	        }
	        #endif                          
	        ENDGLSL        
	    }
	    
	    Pass {            
	    	//Cull Off
		        ZWrite Off Blend SrcAlpha OneMinusSrcAlpha
	        GLSLPROGRAM                          
	        #ifdef VERTEX  
	        uniform float _Outline;
			uniform vec4 _GlowColor;
	        uniform vec4 _ScaleTrick;
	        uniform mat4 _World2Object; 
	        void main()
	        {  
	        	float _Oclusion=0.6;
	        	gl_Position = gl_ModelViewProjectionMatrix * (gl_Vertex+(_Outline*_Oclusion*vec4(gl_Normal, 0.0))/5.0);
	        }
	        #endif  
	        #ifdef FRAGMENT
	        uniform vec4 _GlowColor;
	        uniform float _Opacity;
	        void main()
	        {          
	           gl_FragColor = vec4(_GlowColor.r,_GlowColor.g,_GlowColor.b, _Opacity/10.0);
	        }
	        #endif                          
	        ENDGLSL        
	    }
	    
	    Pass {            
	    	//Cull Off
		        ZWrite Off Blend SrcAlpha OneMinusSrcAlpha
	        GLSLPROGRAM                          
	        #ifdef VERTEX  
	        uniform float _Outline;
			uniform vec4 _GlowColor;
	        uniform vec4 _ScaleTrick;
	        uniform mat4 _World2Object; 
	        void main()
	        {  
	        	float _Oclusion=0.8;	
				gl_Position = gl_ModelViewProjectionMatrix * (gl_Vertex+(_Outline*_Oclusion*vec4(gl_Normal, 0.0))/5.0);
	        }
	        #endif  
	        #ifdef FRAGMENT
	        uniform vec4 _GlowColor;
	        uniform float _Opacity;
	        void main()
	        {          
	           gl_FragColor = vec4(_GlowColor.r,_GlowColor.g,_GlowColor.b, _Opacity/10.0);
	        }
	        #endif                          
	        ENDGLSL        
	    }
	    
	    CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG   
     }
     Fallback "Diffuse"
}