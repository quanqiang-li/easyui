package com.easyui.common.util;

import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.List;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.conn.ssl.X509HostnameVerifier;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;

@SuppressWarnings("deprecation")
public class HttpClientUtil {

	/**
	 * Get方式发起请求http/https
	 * 
	 * @param url
	 *            请求的url
	 * @return 响应结果，字符串数组，内容为： [0] 响应状态码，[1]响应内容
	 */
	public static String[] requestByGetMethod(String url) {
		String[] result = new String[2];
		// 创建默认的httpClient实例
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse httpResponse = null;
		if (url.startsWith("https")) {
			httpClient = createSSLInsecureClient();
		} else {
			httpClient = HttpClients.createDefault();;
		}
		try {
			// 用get方法发送http请求
			HttpGet get = new HttpGet(url);
			// 发送get请求
			System.out.println("get 请求...." + get.getURI());
			httpResponse = httpClient.execute(get);
			// response实体
			HttpEntity entity = httpResponse.getEntity();
			if (null != entity) {
				result[0] = httpResponse.getStatusLine().toString();// 响应状态码
				result[1] = EntityUtils.toString(entity, "UTF-8");// 响应内容，必须在close之前消费，否则会清空，只保留缓存的一小部分
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeHttpResponse(httpResponse);
			closeHttpClient(httpClient);
		}
		return result;
	}

	/**
	 * POST方式发起http请求
	 * 
	 * @param url
	 *            post请求的URL
	 * @param list
	 *            请求参数列表
	 * @return 响应结果，字符串数组，内容为： [0] 响应状态码，[1]响应内容
	 */
	public static String[] requestByPostMethod(String url,
			List<NameValuePair> list) {
		String[] result = new String[2];
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse httpResponse = null;
		if (url.startsWith("https")) {
			httpClient = createSSLInsecureClient();
		} else {
			httpClient = HttpClients.createDefault();;
		}
		try {
			HttpPost post = new HttpPost(url);
			// url格式编码
			if(null != list){
				UrlEncodedFormEntity uefEntity = new UrlEncodedFormEntity(list,	"UTF-8");
				post.setEntity(uefEntity);
			}
			System.out.println("POST 请求...." + post.getURI());
			// 执行请求
			httpResponse = httpClient.execute(post);
			HttpEntity entity = httpResponse.getEntity();
			if (null != entity) {
				result[0] = httpResponse.getStatusLine().toString();// 响应状态码
				result[1] = EntityUtils.toString(entity, "UTF-8");// 响应内容
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeHttpResponse(httpResponse);
			closeHttpClient(httpClient);
		}
		return result;
	}

	private static void closeHttpClient(CloseableHttpClient client) {
		if (client != null) {
			try {
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private static void closeHttpResponse(CloseableHttpResponse httpResponse) {
		if (httpResponse != null) {
			try {
				httpResponse.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 创建 SSL连接
	 * 
	 * @return
	 * @throws GeneralSecurityException
	 */
	private static CloseableHttpClient createSSLInsecureClient() {
		try {
			SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(
					null, new TrustStrategy() {

						public boolean isTrusted(X509Certificate[] chain,
								String authType) throws CertificateException {
							return true;
						}
					}).build();

			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
					sslContext, new X509HostnameVerifier() {

						public boolean verify(String arg0, SSLSession arg1) {
							return true;
						}

						public void verify(String host, SSLSocket ssl)
								throws IOException {
						}

						public void verify(String host, X509Certificate cert)
								throws SSLException {
						}

						public void verify(String host, String[] cns,
								String[] subjectAlts) throws SSLException {
						}

					});

			return HttpClients.custom().setSSLSocketFactory(sslsf).build();

		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 创建ssl连接，需要证书及密码
	 * @param caFile 证书文件，如my.keystore
	 * @param storePassword 证书密码
	 * @return
	 * @throws Exception
	 */
	public static CloseableHttpClient createSSLClientWithKey(String caFile,String storePassword) throws Exception{
		// Trust own CA and all self-signed certs
		SSLContext sslcontext = SSLContexts.custom()
				.loadTrustMaterial(new File(caFile), storePassword.toCharArray(),
						new TrustSelfSignedStrategy())
						.build();
		// Allow TLSv1 protocol only
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
				sslcontext,
				new String[] { "TLSv1" },
				null,
				SSLConnectionSocketFactory.getDefaultHostnameVerifier());
		CloseableHttpClient httpclient = HttpClients.custom()
				.setSSLSocketFactory(sslsf)
				.build();
		return httpclient;
	}
	
	
	public static void main(String[] args) {
		String[] requestByGetMethod = requestByGetMethod("https://www.baidu.com");
		System.out.println(Arrays.deepToString(requestByGetMethod));
		 String[] requestByPostMethod = requestByPostMethod(
				"https://www.baidu.com", null);
		 System.out.println(Arrays.deepToString(requestByPostMethod));
	}
}
