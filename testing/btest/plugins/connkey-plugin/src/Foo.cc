
#include "Foo.h"

#include <cstdio>
#include <memory>

#include "zeek/Desc.h"
#include "zeek/Val.h"
#include "zeek/iosource/Packet.h"
#include "zeek/packet_analysis/protocol/ip/conn_key/IPBasedConnKey.h"
#include "zeek/session/Key.h"

using namespace btest::plugin::Demo_Foo;

namespace {

// Just track how often DoInit() was called for baselining.
int all_inits = 0;

class MyConnKey : public zeek::IPConnKey {
public:
    MyConnKey(int inits) : zeek::IPConnKey(), inits(inits) {}

    void DoInit(const zeek::Packet& pkt) override { ++all_inits; }

    void DoPopulateConnIdVal(zeek::RecordVal& conn_id, zeek::RecordVal& ctx) override {
        static int offset = conn_id.GetType<zeek::RecordType>()->FieldOffset("inits");
        static int offset_ctx = ctx.GetType<zeek::RecordType>()->FieldOffset("inits");

        IPConnKey::DoPopulateConnIdVal(conn_id, ctx);

        conn_id.Assign(offset, zeek::make_intrusive<zeek::IntVal>(inits));
        ctx.Assign(offset_ctx, zeek::make_intrusive<zeek::StringVal>(std::to_string(inits)));
    }

private:
    int inits;
};

} // namespace

zeek::ConnKeyPtr FooFactory::DoNewConnKey() const {
    std::printf("DoNewConnKey (%d key all_inits)\n", all_inits);
    return std::make_unique<MyConnKey>(all_inits);
}
zeek::expected<zeek::ConnKeyPtr, std::string> FooFactory::DoConnKeyFromVal(const zeek::Val& v) const {
    std::printf("DoConnKeyFromVal for %s\n", zeek::obj_desc_short(&v).c_str());
    return zeek::conn_key::fivetuple::Factory::DoConnKeyFromVal(v);
}
zeek::conn_key::FactoryPtr FooFactory::Instantiate() { return std::make_unique<FooFactory>(); }
