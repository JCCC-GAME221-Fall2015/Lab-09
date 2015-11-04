Shader "TestShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
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
		
		
			//float4 texture = tex2D(_MainTex, _MainTex_ST.xy * input.Texture.xy + _MainTex_ST.zw);
		
			//input struct
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float4 textureCoord : TEXCOORD0;
			};
			
			//output struct
			struct outputStruct
			{
				float4 pixelPos : SV_POSITION;
				float4 tex : TEXCOORD0;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				
				//Assigning the info that the inputStruct gathered
				//to the struct that will be passed into the fragment
				//program so that the fragment program can use it.
				toReturn.tex = input.textureCoord;
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
				
				return tex;
			}
		
			ENDCG
			}
	} 
	FallBack "Diffuse"
}


















