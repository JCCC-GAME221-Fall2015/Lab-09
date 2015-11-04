Shader "Lambert_Dark"
{
	Properties
	{
		_Color ("Color", Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}
			CGPROGRAM //En Espanol, por favor!
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			
			uniform float3 _LightColor0;
			
			//structs
			struct VertInput
			{
				float4 vertPos : POSITION;
				float3 vertNorm : NORMAL;
			};
			
			struct VertOutput
			{
				float4 pos : SV_POSITION;
				float4 colour : COLOR;
			};
			
			//vertex function
			VertOutput vertexFunction(VertInput input)
			{
				VertOutput output;
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;
				float attenuation = 1.0;
				float3 lightDir;
				lightDir = normalize(_WorldSpaceLightPos0.xyz);
				
				float3 tempNorm = input.vertNorm;
				
				float3 objNorm = normalize(mul(float4(tempNorm, 1.0), _World2Object).xyz);
				
				float3 diffuseReflection = (max (0.0, dot(lightDir, objNorm)) * _LightColor0 + ambientLight) * _Color.rgb * attenuation;
				
				output.pos = mul(UNITY_MATRIX_MVP, input.vertPos);
				output.colour = float4(diffuseReflection, 1.0);
				return output;
			}
			
			//fragment function
			float4 fragmentFunction(VertOutput input) : COLOR
			{
				return input.colour;
			}
			ENDCG
		}
	}
}