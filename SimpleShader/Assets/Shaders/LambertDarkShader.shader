Shader "LambertDarkShader"
{
	Properties	// Interface between shaders and unity/the inspector
	{
		//Name ('Display name', Type) = Default()
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	Subshader	// Start of our shader
	{
		Pass	// Layering effects on top of eachother
		{
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction

			// user defined variables
			uniform float4 _Color;

			// structs
			struct inputInformation	// vertInput
			{
				float4 vertexPos : POSITION;
				float3 vertexNormal : NORMAL;

			};

			struct passToFragment	// vertOutput
			{
				float4 position : SV_POSITION;
				float4 color : COLOR;
			};

			// vertex function
			passToFragment vertexFunction(inputInformation input)
			{
				passToFragment output;

				output.color = float4(input.vertexNormal, 1.0);

				output.position = mul(UNITY_MATRIX_MVP, input.vertexPos);
				return output;
			}

			// fragment function
			float4 fragmentFunction(passToFragment input) : COLOR
			{
				return input.color;
			}

			ENDCG
		}
	}

	// Fallback
}