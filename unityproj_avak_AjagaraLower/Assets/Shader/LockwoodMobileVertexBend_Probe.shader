Shader "Lockwood/Mobile/VertexBend_Probe" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_WindDirection ("Wind Direction", Vector) = (1,1,1,1)
		_WindEdgeFlutterFactorScale ("Wind edge fultter factor scale", Float) = 0.5
		_WindEdgeFlutterFreqScale ("Wind edge fultter freq scale", Float) = 0.5
	}
	SubShader {
		LOD 100
		Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
			GpuProgramID 58858
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _WindDirection;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp float _WindEdgeFlutterFactorScale;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp float bendingFact_2;
					  highp vec4 wind_3;
					  mediump vec2 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.x;
					  bendingFact_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (_glesColor.y * _WindEdgeFlutterFactorScale);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  wind_3.xyz = (tmpvar_8 * _WindDirection.xyz);
					  wind_3.w = (_WindDirection.w * bendingFact_2);
					  highp vec2 tmpvar_9;
					  tmpvar_9.y = 1.0;
					  tmpvar_9.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_10;
					  pos_10.w = _glesVertex.w;
					  highp vec3 bend_11;
					  highp vec4 v_12;
					  v_12.x = unity_ObjectToWorld[0].w;
					  v_12.y = unity_ObjectToWorld[1].w;
					  v_12.z = unity_ObjectToWorld[2].w;
					  v_12.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (v_12.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_14;
					  tmpvar_14.x = dot (_glesVertex.xyz, vec3((tmpvar_7 + tmpvar_13)));
					  tmpvar_14.y = tmpvar_13;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_9).xx + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_16;
					  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
					  bend_11.xz = ((tmpvar_7 * 0.1) * _glesNormal).xz;
					  bend_11.y = (bendingFact_2 * 0.3);
					  pos_10.xyz = (_glesVertex.xyz + ((
					    (tmpvar_17.xyx * bend_11)
					   + 
					    ((wind_3.xyz * tmpvar_17.y) * bendingFact_2)
					  ) * wind_3.w));
					  pos_10.xyz = (pos_10.xyz + (bendingFact_2 * wind_3.xyz));
					  highp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = pos_10.xyz;
					  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp mat3 tmpvar_19;
					  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (tmpvar_19 * _glesNormal);
					  worldN_1 = tmpvar_20;
					  mediump vec3 tmpvar_21;
					  tmpvar_21 = normalize(worldN_1);
					  mediump vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, tmpvar_22);
					  x_24.y = dot (unity_SHAg, tmpvar_22);
					  x_24.z = dot (unity_SHAb, tmpvar_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (tmpvar_21.xyzz * tmpvar_21.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((tmpvar_21.x * tmpvar_21.x) - (tmpvar_21.y * tmpvar_21.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_5 = (_LightColor0.xyz + res_23);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD1);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _WindDirection;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp float _WindEdgeFlutterFactorScale;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp float bendingFact_2;
					  highp vec4 wind_3;
					  mediump vec2 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.x;
					  bendingFact_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (_glesColor.y * _WindEdgeFlutterFactorScale);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  wind_3.xyz = (tmpvar_8 * _WindDirection.xyz);
					  wind_3.w = (_WindDirection.w * bendingFact_2);
					  highp vec2 tmpvar_9;
					  tmpvar_9.y = 1.0;
					  tmpvar_9.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_10;
					  pos_10.w = _glesVertex.w;
					  highp vec3 bend_11;
					  highp vec4 v_12;
					  v_12.x = unity_ObjectToWorld[0].w;
					  v_12.y = unity_ObjectToWorld[1].w;
					  v_12.z = unity_ObjectToWorld[2].w;
					  v_12.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (v_12.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_14;
					  tmpvar_14.x = dot (_glesVertex.xyz, vec3((tmpvar_7 + tmpvar_13)));
					  tmpvar_14.y = tmpvar_13;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_9).xx + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_16;
					  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
					  bend_11.xz = ((tmpvar_7 * 0.1) * _glesNormal).xz;
					  bend_11.y = (bendingFact_2 * 0.3);
					  pos_10.xyz = (_glesVertex.xyz + ((
					    (tmpvar_17.xyx * bend_11)
					   + 
					    ((wind_3.xyz * tmpvar_17.y) * bendingFact_2)
					  ) * wind_3.w));
					  pos_10.xyz = (pos_10.xyz + (bendingFact_2 * wind_3.xyz));
					  highp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = pos_10.xyz;
					  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp mat3 tmpvar_19;
					  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (tmpvar_19 * _glesNormal);
					  worldN_1 = tmpvar_20;
					  mediump vec3 tmpvar_21;
					  tmpvar_21 = normalize(worldN_1);
					  mediump vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, tmpvar_22);
					  x_24.y = dot (unity_SHAg, tmpvar_22);
					  x_24.z = dot (unity_SHAb, tmpvar_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (tmpvar_21.xyzz * tmpvar_21.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((tmpvar_21.x * tmpvar_21.x) - (tmpvar_21.y * tmpvar_21.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_5 = (_LightColor0.xyz + res_23);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD1);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _WindDirection;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp float _WindEdgeFlutterFactorScale;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp float bendingFact_2;
					  highp vec4 wind_3;
					  mediump vec2 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.x;
					  bendingFact_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (_glesColor.y * _WindEdgeFlutterFactorScale);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  wind_3.xyz = (tmpvar_8 * _WindDirection.xyz);
					  wind_3.w = (_WindDirection.w * bendingFact_2);
					  highp vec2 tmpvar_9;
					  tmpvar_9.y = 1.0;
					  tmpvar_9.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_10;
					  pos_10.w = _glesVertex.w;
					  highp vec3 bend_11;
					  highp vec4 v_12;
					  v_12.x = unity_ObjectToWorld[0].w;
					  v_12.y = unity_ObjectToWorld[1].w;
					  v_12.z = unity_ObjectToWorld[2].w;
					  v_12.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (v_12.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_14;
					  tmpvar_14.x = dot (_glesVertex.xyz, vec3((tmpvar_7 + tmpvar_13)));
					  tmpvar_14.y = tmpvar_13;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_9).xx + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_16;
					  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
					  bend_11.xz = ((tmpvar_7 * 0.1) * _glesNormal).xz;
					  bend_11.y = (bendingFact_2 * 0.3);
					  pos_10.xyz = (_glesVertex.xyz + ((
					    (tmpvar_17.xyx * bend_11)
					   + 
					    ((wind_3.xyz * tmpvar_17.y) * bendingFact_2)
					  ) * wind_3.w));
					  pos_10.xyz = (pos_10.xyz + (bendingFact_2 * wind_3.xyz));
					  highp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = pos_10.xyz;
					  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp mat3 tmpvar_19;
					  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (tmpvar_19 * _glesNormal);
					  worldN_1 = tmpvar_20;
					  mediump vec3 tmpvar_21;
					  tmpvar_21 = normalize(worldN_1);
					  mediump vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, tmpvar_22);
					  x_24.y = dot (unity_SHAg, tmpvar_22);
					  x_24.z = dot (unity_SHAb, tmpvar_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (tmpvar_21.xyzz * tmpvar_21.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((tmpvar_21.x * tmpvar_21.x) - (tmpvar_21.y * tmpvar_21.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_5 = (_LightColor0.xyz + res_23);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying mediump vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD1);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
	}
	Fallback "Lockwood/Mobile/VertexBend"
}