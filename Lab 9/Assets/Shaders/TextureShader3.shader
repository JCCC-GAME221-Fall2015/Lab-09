Shader "Custom/TextureShader3" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex("Diffuse Texture", 2D) = "white" {}
	}

	SubShader {
		Pass{
			
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			//unity defined variables
			
			//input struct
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float4 textureCoord : TEXCOORD0;
			};
			
			//output struct
			struct outputStruct
			{
				float4 pixelPos: SV_POSITION;
				float4 tex: TEXCOORD0;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				toReturn.tex = input.textureCoord;
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
//				float4 tex = tex2D(_MainTex, input.tex.xy);
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
		
//				return tex.rgba;
				return float4(tex.rgb, 1.0);
//				return _Color;
			}
			

			ENDCG
		} 
	}
	
	//Fallback
	//FallBack "Diffuse"
}

//Shader "Custom/TextureShader" {
//	Properties {
//		_Color ("Color", Color) = (1,1,1,1)
//		_MainTex ("Albedo (RGB)", 2D) = "white" {}
//		_Glossiness ("Smoothness", Range(0,1)) = 0.5
//		_Metallic ("Metallic", Range(0,1)) = 0.0
//	}
//	SubShader {
//		Tags { "RenderType"="Opaque" }
//		LOD 200
//		
//		CGPROGRAM
//		// Physically based Standard lighting model, and enable shadows on all light types
//		#pragma surface surf Standard fullforwardshadows
//
//		// Use shader model 3.0 target, to get nicer looking lighting
//		#pragma target 3.0
//
//		sampler2D _MainTex;
//
//		struct Input {
//			float2 uv_MainTex;
//		};
//
//		half _Glossiness;
//		half _Metallic;
//		fixed4 _Color;
//
//		void surf (Input IN, inout SurfaceOutputStandard o) {
//			// Albedo comes from a texture tinted by color
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
//			o.Albedo = c.rgb;
//			// Metallic and smoothness come from slider variables
//			o.Metallic = _Metallic;
//			o.Smoothness = _Glossiness;
//			o.Alpha = c.a;
//		}
//		ENDCG
//	} 
//	FallBack "Diffuse"
//}
