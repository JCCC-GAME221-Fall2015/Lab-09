Shader "TextureShader" {
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM //En français s'il vous plait!
			
			//pragmas
			#pragma vertex vertFunction
			#pragma fragment fragFunction
			//user defined variables
			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			//unity defined variables
			
			//structs
			struct vertInput
			{
				float4 vertPos : POSITION;
				float4 textureCoord : TEXCOORD0;
			};
			
			struct vertOutput
			{
				float4 pixelPos : SV_POSITION;
				float4 tex : TEXCOORD0;
			};
			
			//vertex program
			vertOutput vertFunction(vertInput input)
			{
				vertOutput output;
				output.pixelPos = mul(UNITY_MATRIX_MVP, input.vertPos);
				output.tex = input.textureCoord;
				return output;
			}
			
			//fragment program
			float4 fragFunction(vertOutput input) : COLOR
			{
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
				return tex;
			}
			ENDCG
		}
	} 
	//FallBack "Diffuse"
}
