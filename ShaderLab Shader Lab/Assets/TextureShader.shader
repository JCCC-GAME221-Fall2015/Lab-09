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
			uniform float3 _LightColor0;
			
			//structs
			struct vertInput
			{
				float4 vertPos : POSITION;
				float4 textureCoord : TEXCOORD0;
				float3 vertNorm : NORMAL;
			};
			
			struct vertOutput
			{
				float4 pixelPos : SV_POSITION;
				float4 tex : TEXCOORD0;
				float4 colour : COLOR;
			};
			
			//vertex program
			vertOutput vertFunction(vertInput input)
			{
				vertOutput output;
				output.pixelPos = mul(UNITY_MATRIX_MVP, input.vertPos);
				output.tex = input.textureCoord;
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;
				float attenuation = 1.0;
				float3 lightDir;
				lightDir = normalize(_WorldSpaceLightPos0.xyz);
				
				float3 tempNorm = input.vertNorm;
				
				float3 objNorm = normalize(mul(float4(tempNorm, 1.0), _World2Object).xyz);
				
				float3 diffuseReflection = (max (0.0, dot(lightDir, objNorm)) * _LightColor0 + ambientLight) * _Color.rgb * attenuation;
				output.colour = float4(diffuseReflection, 1.0);
				
				return output;
			}
			
			//fragment program
			float4 fragFunction(vertOutput input) : COLOR
			{
				float4 tex = tex2D(_MainTex, _MainTex_ST.xy * input.tex.xy + _MainTex_ST.zw);
				return tex * input.colour;
			}
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
