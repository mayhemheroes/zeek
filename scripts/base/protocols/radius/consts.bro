
module RADIUS;

const msg_types: table[count] of string = {
	[1] = "Access-Request",
	[2] = "Access-Accept",
	[3] = "Access-Reject",
	[4] = "Accounting-Request",
	[5] = "Accounting-Response",
	[11] = "Access-Challenge",
	[12] = "Status-Server",
	[13] = "Status-Client",
} &default=function(i: count): string { return fmt("unknown-%d", i); };

const attr_types: table[count] of string = {
	[1] = "User-Name",
	[2] = "User-Password",
	[3] = "CHAP-Password",
	[4] = "NAS-IP-Address",
	[5] = "NAS-Port",
	[6] = "Service-Type",
	[7] = "Framed-Protocol",
	[8] = "Framed-IP-Address",
	[9] = "Framed-IP-Netmask",
	[10] = "Framed-Routing",
	[11] = "Filter-Id",
	[12] = "Framed-MTU",
	[13] = "Framed-Compression",
	[14] = "Login-IP-Host",
	[15] = "Login-Service",
	[16] = "Login-TCP-Port",
	[18] = "Reply-Message",
	[19] = "Callback-Number",
	[20] = "Callback-Id",
	[22] = "Framed-Route",
	[23] = "Framed-IPX-Network",
	[24] = "State",
	[25] = "Class",
	[26] = "Vendor-Specific",
	[27] = "Session-Timeout",
	[28] = "Idle-Timeout",
	[29] = "Termination-Action",
	[30] = "Called-Station-Id",
	[31] = "Calling-Station-Id",
	[32] = "NAS-Identifier",
	[33] = "Proxy-State",
	[34] = "Login-LAT-Service",
	[35] = "Login-LAT-Node",
	[36] = "Login-LAT-Group",
	[37] = "Framed-AppleTalk-Link",
	[38] = "Framed-AppleTalk-Network",
	[39] = "Framed-AppleTalk-Zone",
	[40] = "Acct-Status-Type",
	[41] = "Acct-Delay-Time",
	[42] = "Acct-Input-Octets",
	[43] = "Acct-Output-Octets",
	[44] = "Acct-Session-Id",
	[45] = "Acct-Authentic",
	[46] = "Acct-Session-Time",
	[47] = "Acct-Input-Packets",
	[48] = "Acct-Output-Packets",
	[49] = "Acct-Terminate-Cause",
	[50] = "Acct-Multi-Session-Id",
	[51] = "Acct-Link-Count",
	[52] = "Acct-Input-Gigawords",
	[53] = "Acct-Output-Gigawords",
	[55] = "Event-Timestamp",
	[56] = "Egress-VLANID",
	[57] = "Ingress-Filters",
	[58] = "Egress-VLAN-Name",
	[59] = "User-Priority-Table",
	[60] = "CHAP-Challenge",
	[61] = "NAS-Port-Type",
	[62] = "Port-Limit",
	[63] = "Login-LAT-Port",
	[64] = "Tunnel-Type",
	[65] = "Tunnel-Medium-Type",
	[66] = "Tunnel-Client-EndPoint",
	[67] = "Tunnel-Server-EndPoint",
	[68] = "Acct-Tunnel-Connection",
	[69] = "Tunnel-Password",
	[70] = "ARAP-Password",
	[71] = "ARAP-Features",
	[72] = "ARAP-Zone-Access",
	[73] = "ARAP-Security",
	[74] = "ARAP-Security-Data",
	[75] = "Password-Retry",
	[76] = "Prompt",
	[77] = "Connect-Info",
	[78] = "Configuration-Token",
	[79] = "EAP-Message",
	[80] = "Message Authenticator",
	[81] = "Tunnel-Private-Group-ID",
	[82] = "Tunnel-Assignment-ID",
	[83] = "Tunnel-Preference",
	[84] = "ARAP-Challenge-Response",
	[85] = "Acct-Interim-Interval",
	[86] = "Acct-Tunnel-Packets-Lost",
	[87] = "NAS-Port-Id",
	[88] = "Framed-Pool",
	[89] = "CUI",
	[90] = "Tunnel-Client-Auth-ID",
	[91] = "Tunnel-Server-Auth-ID",
	[92] = "NAS-Filter-Rule",
	[94] = "Originating-Line-Info",
	[95] = "NAS-IPv6-Address",
	[96] = "Framed-Interface-Id",
	[97] = "Framed-IPv6-Prefix",
	[98] = "Login-IPv6-Host",
	[99] = "Framed-IPv6-Route",
	[100] = "Framed-IPv6-Pool",
	[101] = "Error-Cause",
	[102] = "EAP-Key-Name",
	[103] = "Digest-Response",
	[104] = "Digest-Realm",
	[105] = "Digest-Nonce",
	[106] = "Digest-Response-Auth",
	[107] = "Digest-Nextnonce",
	[108] = "Digest-Method",
	[109] = "Digest-URI",
	[110] = "Digest-Qop",
	[111] = "Digest-Algorithm",
	[112] = "Digest-Entity-Body-Hash",
	[113] = "Digest-CNonce",
	[114] = "Digest-Nonce-Count",
	[115] = "Digest-Username",
	[116] = "Digest-Opaque",
	[117] = "Digest-Auth-Param",
	[118] = "Digest-AKA-Auts",
	[119] = "Digest-Domain",
	[120] = "Digest-Stale",
	[121] = "Digest-HA1",
	[122] = "SIP-AOR",
	[123] = "Delegated-IPv6-Prefix",
	[124] = "MIP6-Feature-Vector",
	[125] = "MIP6-Home-Link-Prefix",
	[126] = "Operator-Name",
	[127] = "Location-Information",
	[128] = "Location-Data",
	[129] = "Basic-Location-Policy-Rules",
	[130] = "Extended-Location-Policy-Rules",
	[131] = "Location-Capable",
	[132] = "Requested-Location-Info",
	[133] = "Framed-Management-Protocol",
	[134] = "Management-Transport-Protection",
	[135] = "Management-Policy-Id",
	[136] = "Management-Privilege-Level",
	[137] = "PKM-SS-Cert",
	[138] = "PKM-CA-Cert",
	[139] = "PKM-Config-Settings",
	[140] = "PKM-Cryptosuite-List",
	[141] = "PKM-SAID",
	[142] = "PKM-SA-Descriptor",
	[143] = "PKM-Auth-Key",
	[144] = "DS-Lite-Tunnel-Name",
	[145] = "Mobile-Node-Identifier",
	[146] = "Service-Selection",
	[147] = "PMIP6-Home-LMA-IPv6-Address",
	[148] = "PMIP6-Visited-LMA-IPv6-Address",
	[149] = "PMIP6-Home-LMA-IPv4-Address",
	[150] = "PMIP6-Visited-LMA-IPv4-Address",
	[151] = "PMIP6-Home-HN-Prefix",
	[152] = "PMIP6-Visited-HN-Prefix",
	[153] = "PMIP6-Home-Interface-ID",
	[154] = "PMIP6-Visited-Interface-ID",
	[155] = "PMIP6-Home-IPv4-HoA",
	[156] = "PMIP6-Visited-IPv4-HoA",
	[157] = "PMIP6-Home-DHCP4-Server-Address",
	[158] = "PMIP6-Visited-DHCP4-Server-Address",
	[159] = "PMIP6-Home-DHCP6-Server-Address",
	[160] = "PMIP6-Visited-DHCP6-Server-Address",
	[161] = "PMIP6-Home-IPv4-Gateway",
	[162] = "PMIP6-Visited-IPv4-Gateway",
	[163] = "EAP-Lower-Layer",
	[164] = "GSS-Acceptor-Service-Name",
	[165] = "GSS-Acceptor-Host-Name",
	[166] = "GSS-Acceptor-Service-Specifics",
	[167] = "GSS-Acceptor-Realm-Name",
	[168] = "Framed-IPv6-Address",
	[169] = "DNS-Server-IPv6-Address",
	[170] = "Route-IPv6-Information",
	[171] = "Delegated-IPv6-Prefix-Pool",
	[172] = "Stateful-IPv6-Address-Pool",
	[173] = "IPv6-6rd-Configuration"
} &default=function(i: count): string { return fmt("unknown-%d", i); };

const nas_port_types: table[count] of string = {
	[0] = "Async",
	[1] = "Sync",
	[2] = "ISDN Sync",
	[3] = "ISDN Async V.120",
	[4] = "ISDN Async V.110",
	[5] = "Virtual",
	[6] = "PIAFS",
	[7] = "HDLC Clear Channel",
	[8] = "X.25",
	[9] = "X.75",
	[10] = "G.3 Fax",
	[11] = "SDSL - Symmetric DSL",
	[12] = "ADSL-CAP - Asymmetric DSL, Carrierless Amplitude Phase Modulation",
	[13] = "ADSL-DMT - Asymmetric DSL, Discrete Multi-Tone",
	[14] = "IDSL - ISDN Digital Subscriber Line",
	[15] = "Ethernet",
	[16] = "xDSL - Digital Subscriber Line of unknown type",
	[17] = "Cable",
	[18] = "Wireless - Other",
	[19] = "Wireless - IEEE 802.11"
} &default=function(i: count): string { return fmt("unknown-%d", i); };

const service_types: table[count] of string = {
	[1] = "Login",
	[2] = "Framed",
	[3] = "Callback Login",
	[4] = "Callback Framed",
	[5] = "Outbound",
	[6] = "Administrative",
	[7] = "NAS Prompt",
	[8] = "Authenticate Only",
	[9] = "Callback NAS Prompt",
	[10] = "Call Check",
	[11] = "Callback Administrative",
} &default=function(i: count): string { return fmt("unknown-%d", i); };

const framed_protocol_types: table[count] of string = {
	[1] = "PPP",
	[2] = "SLIP",
	[3] = "AppleTalk Remote Access Protocol (ARAP)",
	[4] = "Gandalf proprietary SingleLink/MultiLink protocol",
	[5] = "Xylogics proprietary IPX/SLIP",
	[6] = "X.75 Synchronous"
} &default=function(i: count): string { return fmt("unknown-%d", i); };
