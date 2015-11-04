Shader "SimpleShader"
{
	Properties
	{
		// Actual name of the property (name that the user will see in the inspector, Type) = Default Value
		_Color("Flibberty Ghibbet", Color) = (0.0, 0.0, 0.0, 1.0)
	}

		Subshader
	{
		Pass
		{
			CGPROGRAM
			// Pragmas
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction

			// User defined var
			uniform float4 _Color;
				

				// Structs for passing data
				struct vertexInput
				{
					float4 vertexPosition : POSITION;		// Get the vertex position

				};
				
				struct vertexOutput
				{
					float4 position : SV_POSITION;			// Output the vertex position
				};


				// Semantics
					// COLOR - the color of the vertex
					// POSITION - the position of the vertex
					// SV_POSITION - output position of vertex, dx11, output ONLY
					// NORMAL - normal of the vertex
					// TANGENT - tangent direction
					// TEXCOORD0 - the first UV map
					// TEXCOORD1 - the second UV map
					// TEXCOORD2-??? - Empty semantics for data transfer


				// Vertex function
				vertexOutput vertexFunction(vertexInput input)
				{
					vertexOutput returnVertex;

					returnVertex.position = mul(UNITY_MATRIX_MVP, input.vertexPosition);

					return returnVertex;
				}

				// Fragment function aka pixel shader
				float4 fragmentFunction(vertexOutput output) : COLOR
				{
					
					return _Color;
				}

			ENDCG
		}
	}

	// Fallback
	//Fallback "Diffuse"
}