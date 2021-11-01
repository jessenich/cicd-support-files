#!/usr/bin/env dotnet-script

#r "System.Net.Http"

using System.Xml;
using System.Diagnostics.CodeAnalysis;
using System.Net.Http;


var client = new HttpClient();
var response = await client.GetStringAsync("https://protonvpn.com/support/official-linux-vpn-debian/");
var xmlDoc = new XmlDocument();
xmlDoc.Load(response)
