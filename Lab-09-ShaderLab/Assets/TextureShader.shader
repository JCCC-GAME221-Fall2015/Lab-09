Shader "Custom/TextureShader"
{
	Properties
	{
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float4 textureCoord : TEXCOORD0;
				float3 vertexNormal : NORMAL;
			};
			
			struct outputStruct
			{
				float4 pixelPos : SV_POSITION;
				float4 colour : COLOR;
				float4 tex: TEXCOORD0;
			};
			
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				toReturn.tex = input.textureCoord;
				toReturn.colour = float4(input.vertexNormal, 1.0);
				
				return toReturn;
			}
			
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
				return _Color;
			}
			
			ENDCG
		}
	}
	
	//Fallback
	//Fallback "Diffuse"
}