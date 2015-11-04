Shader "Normal"
{
	Properties
	{
		_Color ("Color", Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM //En Espanol, por favor!
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			
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
				
				output.pos = mul(UNITY_MATRIX_MVP, input.vertPos);
				output.colour = float4(input.vertNorm, 1.0);
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