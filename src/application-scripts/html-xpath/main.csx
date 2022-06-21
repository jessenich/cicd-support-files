#!/usr/bin/env dotnet-script

#r "System"
#r "System.Net.Http"
#r "System.Xml.Linq"

#nullable enable

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

    public RemoteXPathSelector(HttpClient httpClient) {
        _client = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
    }

    public async Task<IEnumerable<string>> ExecuteRemoteXPath(string url, string xpathSelector)
    {
        if (string.IsNullOrWhiteSpace(url))
            throw new ArgumentNullException(nameof(url));

        if (!Uri.IsWellFormedUriString(url, UriKind.Absolute))
            throw new ArgumentException("Invalid URL", nameof(url));

        if (string.IsNullOrWhiteSpace(xpathSelector))
            throw new ArgumentNullException(nameof(xpathSelector));

        using var responseStream = await _client.GetStreamAsync(url);
        using var fs = new FileStream($"{new Uri(url).Host}-{url.Split('/').Last()}-{DateTime.Now:yyyyMMddHHmmss}.xml", FileMode.Create);
        await responseStream.CopyToAsync(fs);
        return new XPathDocument(responseStream)
            .CreateNavigator()
            .Select(xpathSelector)
            .Cast<XPathNavigator>()
            .Select(x => x.Value);
    }
}
