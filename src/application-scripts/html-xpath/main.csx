#!/usr/bin/env dotnet-script

#r "System.Net.Http"
using System.Xml.Serialization;

using System.Diagnostics.CodeAnalysis;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization;
using System.Xml;
using System.Xml.XPath;

public sealed class RemoteXPathSelector {
    private readonly HttpClient _client;
    private readonly RemoteXPathSelectorOptions _options;

    public RemoteXPathSelector(HttpClient httpClient) {
        _client = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
    }

    public RemoteXPathSelector(HttpClient httpClient, RemoteXPathSelectorOptions options) {
        if (options is null) {
            throw new ArgumentNullException(nameof(options));
        }

        _client = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
        _options = options?.Value ?? throw new ArgumentNullException(nameof(options));
    }

    public async Task<IEnumerable<string>> ExecuteRemoteXPath(string url, string xpathSelector)
    {
        if (string.IsNullOrWhiteSpace(url))
            throw new ArgumentNullException(nameof(url));

        if (string.IsNullOrWhiteSpace(xpathSelector))
            throw new ArgumentNullException(nameof(xpathSelector));

        var response = await _client.GetAsync(url);
        using var readStream = await response.Content.ReadAsStreamAsync();
        var fs= new FileStream($"{new Uri(url).Host}-{url.Split('/').Last()}-{DateTime.Now.ToString("yyyyMMddHHmmss")}.xml", FileMode.Create)}))
        var xpathDoc = new XPathDocument(readStream);

        var navigator = xmlDoc.CreateNavigator();
        var iterator = navigator.Select(xpathSelector);
        while (iterator.MoveNext()) {
            Console.WriteLine(iterator.Current.Value);
            yield return iterator.Current.Value;
        }
    }
}

public record RemoteXPathSelectorOptions {
    public string LocalCacheLocation { get; } = null!;
}
