// Generated by the protocol buffer compiler.  DO NOT EDIT!
// NO CHECKED-IN PROTOBUF GENCODE
// source: google/protobuf/duration.proto
// Protobuf C++ Version: 5.28.1

#ifndef GOOGLE_PROTOBUF_INCLUDED_google_2fprotobuf_2fduration_2eproto_2epb_2eh
#define GOOGLE_PROTOBUF_INCLUDED_google_2fprotobuf_2fduration_2eproto_2epb_2eh

#include <limits>
#include <string>
#include <type_traits>
#include <utility>

#include "google/protobuf/runtime_version.h"
#if PROTOBUF_VERSION != 5028001
#error "Protobuf C++ gencode is built with an incompatible version of"
#error "Protobuf C++ headers/runtime. See"
#error "https://protobuf.dev/support/cross-version-runtime-guarantee/#cpp"
#endif
#include "google/protobuf/arena.h"
#include "google/protobuf/arenastring.h"
#include "google/protobuf/extension_set.h"  // IWYU pragma: export
#include "google/protobuf/generated_message_reflection.h"
#include "google/protobuf/generated_message_tctable_decl.h"
#include "google/protobuf/generated_message_util.h"
#include "google/protobuf/io/coded_stream.h"
#include "google/protobuf/message.h"
#include "google/protobuf/metadata_lite.h"
#include "google/protobuf/repeated_field.h"  // IWYU pragma: export
#include "google/protobuf/unknown_field_set.h"
// @@protoc_insertion_point(includes)

// Must be included last.
#include "google/protobuf/port_def.inc"

#define PROTOBUF_INTERNAL_EXPORT_google_2fprotobuf_2fduration_2eproto

namespace google
{
namespace protobuf
{
namespace internal
{
class AnyMetadata;
}  // namespace internal
}  // namespace protobuf
}  // namespace google

// Internal implementation detail -- do not use these members.
struct TableStruct_google_2fprotobuf_2fduration_2eproto
{
    static const ::uint32_t offsets[];
};
extern const ::google::protobuf::internal::DescriptorTable
    descriptor_table_google_2fprotobuf_2fduration_2eproto;
namespace google
{
namespace protobuf
{
class Duration;
struct DurationDefaultTypeInternal;
extern DurationDefaultTypeInternal _Duration_default_instance_;
}  // namespace protobuf
}  // namespace google

namespace google
{
namespace protobuf
{

// ===================================================================

// -------------------------------------------------------------------

class Duration final : public ::google::protobuf::Message
/* @@protoc_insertion_point(class_definition:google.protobuf.Duration) */ {
   public:
    inline Duration() : Duration(nullptr) {}
    ~Duration() PROTOBUF_FINAL;
    template <typename = void>
    explicit PROTOBUF_CONSTEXPR Duration(
        ::google::protobuf::internal::ConstantInitialized);

    inline Duration(const Duration& from) : Duration(nullptr, from) {}
    inline Duration(Duration&& from) noexcept
        : Duration(nullptr, std::move(from))
    {}
    inline Duration& operator=(const Duration& from)
    {
        CopyFrom(from);
        return *this;
    }
    inline Duration& operator=(Duration&& from) noexcept
    {
        if(this == &from) return *this;
        if(GetArena() == from.GetArena()
#ifdef PROTOBUF_FORCE_COPY_IN_MOVE
           && GetArena() != nullptr
#endif  // !PROTOBUF_FORCE_COPY_IN_MOVE
        )
        {
            InternalSwap(&from);
        }
        else
        {
            CopyFrom(from);
        }
        return *this;
    }

    inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const
        ABSL_ATTRIBUTE_LIFETIME_BOUND
    {
        return _internal_metadata_
            .unknown_fields<::google::protobuf::UnknownFieldSet>(
                ::google::protobuf::UnknownFieldSet::default_instance);
    }
    inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields()
        ABSL_ATTRIBUTE_LIFETIME_BOUND
    {
        return _internal_metadata_
            .mutable_unknown_fields<::google::protobuf::UnknownFieldSet>();
    }

    static const ::google::protobuf::Descriptor* descriptor()
    {
        return GetDescriptor();
    }
    static const ::google::protobuf::Descriptor* GetDescriptor()
    {
        return default_instance().GetMetadata().descriptor;
    }
    static const ::google::protobuf::Reflection* GetReflection()
    {
        return default_instance().GetMetadata().reflection;
    }
    static const Duration& default_instance()
    {
        return *internal_default_instance();
    }
    static inline const Duration* internal_default_instance()
    {
        return reinterpret_cast<const Duration*>(&_Duration_default_instance_);
    }
    static constexpr int kIndexInFileMessages = 0;
    friend void swap(Duration& a, Duration& b) { a.Swap(&b); }
    inline void Swap(Duration* other)
    {
        if(other == this) return;
#ifdef PROTOBUF_FORCE_COPY_IN_SWAP
        if(GetArena() != nullptr && GetArena() == other->GetArena())
        {
#else   // PROTOBUF_FORCE_COPY_IN_SWAP
        if(GetArena() == other->GetArena())
        {
#endif  // !PROTOBUF_FORCE_COPY_IN_SWAP
            InternalSwap(other);
        }
        else
        {
            ::google::protobuf::internal::GenericSwap(this, other);
        }
    }
    void UnsafeArenaSwap(Duration* other)
    {
        if(other == this) return;
        ABSL_DCHECK(GetArena() == other->GetArena());
        InternalSwap(other);
    }

    // implements Message ----------------------------------------------

    Duration* New(::google::protobuf::Arena* arena = nullptr) const
        PROTOBUF_FINAL
    {
        return ::google::protobuf::Message::DefaultConstruct<Duration>(arena);
    }
    using ::google::protobuf::Message::CopyFrom;
    void CopyFrom(const Duration& from);
    using ::google::protobuf::Message::MergeFrom;
    void MergeFrom(const Duration& from) { Duration::MergeImpl(*this, from); }

   private:
    static void MergeImpl(::google::protobuf::MessageLite& to_msg,
                          const ::google::protobuf::MessageLite& from_msg);

   public:
    bool IsInitialized() const { return true; }
    ABSL_ATTRIBUTE_REINITIALIZES void Clear() PROTOBUF_FINAL;
#if defined(PROTOBUF_CUSTOM_VTABLE)
   private:
    static ::size_t ByteSizeLong(const ::google::protobuf::MessageLite& msg);
    static ::uint8_t* _InternalSerialize(
        const MessageLite& msg, ::uint8_t* target,
        ::google::protobuf::io::EpsCopyOutputStream* stream);

   public:
    ::size_t ByteSizeLong() const { return ByteSizeLong(*this); }
    ::uint8_t* _InternalSerialize(
        ::uint8_t* target,
        ::google::protobuf::io::EpsCopyOutputStream* stream) const
    {
        return _InternalSerialize(*this, target, stream);
    }
#else   // PROTOBUF_CUSTOM_VTABLE
    ::size_t ByteSizeLong() const final;
    ::uint8_t* _InternalSerialize(
        ::uint8_t* target,
        ::google::protobuf::io::EpsCopyOutputStream* stream) const final;
#endif  // PROTOBUF_CUSTOM_VTABLE
    int GetCachedSize() const { return _impl_._cached_size_.Get(); }

   private:
    void SharedCtor(::google::protobuf::Arena* arena);
    void SharedDtor();
    void InternalSwap(Duration* other);

   private:
    friend class ::google::protobuf::internal::AnyMetadata;
    static ::absl::string_view FullMessageName()
    {
        return "google.protobuf.Duration";
    }

   protected:
    explicit Duration(::google::protobuf::Arena* arena);
    Duration(::google::protobuf::Arena* arena, const Duration& from);
    Duration(::google::protobuf::Arena* arena, Duration&& from) noexcept
        : Duration(arena)
    {
        *this = ::std::move(from);
    }
    const ::google::protobuf::Message::ClassData* GetClassData() const
        PROTOBUF_FINAL;
    static const ::google::protobuf::Message::ClassDataFull _class_data_;

   public:
    ::google::protobuf::Metadata GetMetadata() const;
    // nested types ----------------------------------------------------

    // accessors -------------------------------------------------------
    enum : int
    {
        kSecondsFieldNumber = 1,
        kNanosFieldNumber = 2,
    };
    // int64 seconds = 1;
    void clear_seconds();
    ::int64_t seconds() const;
    void set_seconds(::int64_t value);

   private:
    ::int64_t _internal_seconds() const;
    void _internal_set_seconds(::int64_t value);

   public:
    // int32 nanos = 2;
    void clear_nanos();
    ::int32_t nanos() const;
    void set_nanos(::int32_t value);

   private:
    ::int32_t _internal_nanos() const;
    void _internal_set_nanos(::int32_t value);

   public:
    // @@protoc_insertion_point(class_scope:google.protobuf.Duration)
   private:
    class _Internal;
    friend class ::google::protobuf::internal::TcParser;
    static const ::google::protobuf::internal::TcParseTable<1, 2, 0, 0, 2>
        _table_;

    static constexpr const void* _raw_default_instance_ =
        &_Duration_default_instance_;

    friend class ::google::protobuf::MessageLite;
    friend class ::google::protobuf::Arena;
    template <typename T>
    friend class ::google::protobuf::Arena::InternalHelper;
    using InternalArenaConstructable_ = void;
    using DestructorSkippable_ = void;
    struct Impl_
    {
        inline explicit constexpr Impl_(
            ::google::protobuf::internal::ConstantInitialized) noexcept;
        inline explicit Impl_(
            ::google::protobuf::internal::InternalVisibility visibility,
            ::google::protobuf::Arena* arena);
        inline explicit Impl_(
            ::google::protobuf::internal::InternalVisibility visibility,
            ::google::protobuf::Arena* arena, const Impl_& from,
            const Duration& from_msg);
        ::int64_t seconds_;
        ::int32_t nanos_;
        mutable ::google::protobuf::internal::CachedSize _cached_size_;
        PROTOBUF_TSAN_DECLARE_MEMBER
    };
    union
    {
        Impl_ _impl_;
    };
    friend struct ::TableStruct_google_2fprotobuf_2fduration_2eproto;
};

// ===================================================================

// ===================================================================

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// -------------------------------------------------------------------

// Duration

// int64 seconds = 1;
inline void Duration::clear_seconds()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.seconds_ = ::int64_t{0};
}
inline ::int64_t Duration::seconds() const
{
    // @@protoc_insertion_point(field_get:google.protobuf.Duration.seconds)
    return _internal_seconds();
}
inline void Duration::set_seconds(::int64_t value)
{
    _internal_set_seconds(value);
    // @@protoc_insertion_point(field_set:google.protobuf.Duration.seconds)
}
inline ::int64_t Duration::_internal_seconds() const
{
    ::google::protobuf::internal::TSanRead(&_impl_);
    return _impl_.seconds_;
}
inline void Duration::_internal_set_seconds(::int64_t value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.seconds_ = value;
}

// int32 nanos = 2;
inline void Duration::clear_nanos()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.nanos_ = 0;
}
inline ::int32_t Duration::nanos() const
{
    // @@protoc_insertion_point(field_get:google.protobuf.Duration.nanos)
    return _internal_nanos();
}
inline void Duration::set_nanos(::int32_t value)
{
    _internal_set_nanos(value);
    // @@protoc_insertion_point(field_set:google.protobuf.Duration.nanos)
}
inline ::int32_t Duration::_internal_nanos() const
{
    ::google::protobuf::internal::TSanRead(&_impl_);
    return _impl_.nanos_;
}
inline void Duration::_internal_set_nanos(::int32_t value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.nanos_ = value;
}

#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif  // __GNUC__

// @@protoc_insertion_point(namespace_scope)
}  // namespace protobuf
}  // namespace google

// @@protoc_insertion_point(global_scope)

#include "google/protobuf/port_undef.inc"

#endif  // GOOGLE_PROTOBUF_INCLUDED_google_2fprotobuf_2fduration_2eproto_2epb_2eh
