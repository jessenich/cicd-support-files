#!/usr/bin/env dotnet-script

#r "nuget: Microsoft.Extensions.Options, 5.0.0"
#r "System.Net.Http"

using System.Diagnostics.CodeAnalysis;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization;
using System.Xml;
using System.Xml.XPath;
using Microsoft.Extensions.Options;

public sealed class RemoteXPathSelector {
    private readonly HttpClient _client;
    private readonly IOptions<RemoteXPathSelectorOptions> _options;

    public RemoteXPathSelector(HttpClient httpClient) {
        _client = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
    }

    public RemoteXPathSelector(HttpClient httpClient, IOptions<RemoteXPathSelectorOptions> options) {
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
        var xmlDoc = new XPathDocument(await response.Content.ReadAsStreamAsync());
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
