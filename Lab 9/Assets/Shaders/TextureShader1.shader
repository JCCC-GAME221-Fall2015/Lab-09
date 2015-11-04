// TextureShader1.shader
Shader "Custom/TextureShader1" // Lab 9 Shader for On Your Own #1
	{
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
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
		
				return float4(tex.rgb * _Color.rgb, 1.0);
			}
			ENDCG
		} 
	}
	
	//Fallback
	//FallBack "Diffuse"
}
