﻿Shader "3y3net/GlowHiddenNormal"{
	Properties {
		_Color ("Color Tint", Color) = (1.0,1.0,1.0,1.0)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
		_BumpMap ("Normal Texture", 2D) = "bump" {}
		_BumpDepth ("Bump Depth", Range(0.0,1.0)) = 1
		_GlowColor ("Glow Color", Color) = (1,0,0,1)
		_Outline ("Outline width", Range (0.02, 0.25)) = .005
		_Opacity ("Glow Opacity", Range (0.5, 2.0)) = 1.0
		_ScaleTrick ("Scale factor", Color) = (1,1,1,1)
	}		
	
	CGINCLUDE
	#include "UnityCG.cginc"
	struct vinGlow {
		fixed4 vertex : POSITION;
		fixed3 normal : NORMAL;
	};	 
	struct voutGlow {
		fixed4 pos : POSITION;
		fixed4 color : COLOR;
	};
	struct vinObject{
		half4 vertex : POSITION;
		half3 normal : NORMAL;
		half4 texcoord : TEXCOORD0;
		half4 tangent : TANGENT;
	};
	struct voutObject{
		half4 pos : SV_POSITION;
		half4 tex : TEXCOORD0;
		fixed4 ldir : TEXCOORD1;
		fixed3 vdir : TEXCOORD2;
		fixed3 nmvec : TEXCOORD3;
		fixed3 tanvec : TEXCOORD4;
		fixed3 bnmvec : TEXCOORD5;
	};	
		
	uniform fixed4 _Color;
	uniform sampler2D _MainTex;
	uniform sampler2D _BumpMap;
	uniform fixed _BumpDepth;
	uniform fixed4 _GlowColor;
	uniform fixed _Outline;
	uniform fixed _Opacity;
	uniform fixed4 _ScaleTrick;
	//uniform half4 _LightColor0;
	//uniform half4 _MainTex_ST;	
	uniform half4 _BumpMap_ST;	
	
	voutGlow vertPassGlobal(vinGlow v, fixed Occlusion) {
		voutGlow o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		fixed3 norm   = mul ((fixed3x3)UNITY_MATRIX_IT_MV, v.normal);
		fixed2 offset = TransformViewToProjection(norm.xy);
		o.pos.xy += offset * o.pos.z * _Outline*Occlusion/10.0;
		o.color = fixed4(_GlowColor.r,_GlowColor.g,_GlowColor.b,_Opacity/10.0);
		return o;
	}		
	fixed4 fragPass(voutGlow i) : COLOR {
		return i.color;
	}
	
	ENDCG
	
	SubShader {				
		Tags { "Queue" = "Transparent" }
		Pass {
			Name "OUTLINE1" Tags { "LightMode" = "Always" "Queue" = "Transparent" }
			Cull Off ZWrite Off Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM			
			#pragma vertex vertPass
			#pragma fragment fragPass
			voutGlow vertPass(vinGlow v) {				
				return vertPassGlobal(v, 0.2);
			}			
			ENDCG
		}
		
		Pass {
			Name "OUTLINE2" Tags { "LightMode" = "Always" "Queue" = "Transparent" }
			Cull Off ZWrite Off Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM			
			#pragma vertex vertPass
			#pragma fragment fragPass
			voutGlow vertPass(vinGlow v) {				
				return vertPassGlobal(v, 0.4);
			}
			ENDCG
		}
		
		Pass {
			Name "OUTLINE3" Tags { "LightMode" = "Always" "Queue" = "Transparent" }
			Cull Off ZWrite Off Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM			
			#pragma vertex vertPass
			#pragma fragment fragPass
			voutGlow vertPass(vinGlow v) {				
				return vertPassGlobal(v, 0.6);
			}
			ENDCG
		}
		
		Pass {
			Name "OUTLINE4" Tags { "LightMode" = "Always" "Queue" = "Transparent" }
			Cull Off ZWrite Off Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM			
			#pragma vertex vertPass
			#pragma fragment fragPass
			voutGlow vertPass(vinGlow v) {				
				return vertPassGlobal(v, 0.8);
			}
			ENDCG
		}
		
		Pass {
			Name "OUTLINE5" Tags { "LightMode" = "Always" "Queue" = "Transparent" }
			Cull Off ZWrite Off Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM			
			#pragma vertex vertPass
			#pragma fragment fragPass
			voutGlow vertPass(vinGlow v) {				
				return vertPassGlobal(v, 1.0);
			}				
			ENDCG
		}
		
		CGPROGRAM
		#pragma surface surf Lambert

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