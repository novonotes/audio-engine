// Generated by the protocol buffer compiler.  DO NOT EDIT!
// NO CHECKED-IN PROTOBUF GENCODE
// source: novonotes/audio_engine/v1alpha1/debug_utility.proto
// Protobuf C++ Version: 5.28.1

#ifndef GOOGLE_PROTOBUF_INCLUDED_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto_2epb_2eh
#define GOOGLE_PROTOBUF_INCLUDED_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto_2epb_2eh

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
#include "google/api/field_behavior.pb.h"
#include "google/protobuf/arena.h"
#include "google/protobuf/arenastring.h"
#include "google/protobuf/extension_set.h"  // IWYU pragma: export
#include "google/protobuf/generated_message_bases.h"
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

#define PROTOBUF_INTERNAL_EXPORT_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto

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
struct
    TableStruct_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto
{
    static const ::uint32_t offsets[];
};
extern const ::google::protobuf::internal::DescriptorTable
    descriptor_table_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto;
namespace novonotes
{
namespace audio_engine
{
namespace v1alpha1
{
class DebugStateRequest;
struct DebugStateRequestDefaultTypeInternal;
extern DebugStateRequestDefaultTypeInternal
    _DebugStateRequest_default_instance_;
class DebugStateResponse;
struct DebugStateResponseDefaultTypeInternal;
extern DebugStateResponseDefaultTypeInternal
    _DebugStateResponse_default_instance_;
class SaveStateRequest;
struct SaveStateRequestDefaultTypeInternal;
extern SaveStateRequestDefaultTypeInternal _SaveStateRequest_default_instance_;
class SaveStateResponse;
struct SaveStateResponseDefaultTypeInternal;
extern SaveStateResponseDefaultTypeInternal
    _SaveStateResponse_default_instance_;
}  // namespace v1alpha1
}  // namespace audio_engine
}  // namespace novonotes
namespace google
{
namespace protobuf
{}  // namespace protobuf
}  // namespace google

namespace novonotes
{
namespace audio_engine
{
namespace v1alpha1
{

// ===================================================================

// -------------------------------------------------------------------

class SaveStateResponse final
    : public ::google::protobuf::internal::ZeroFieldsBase
/* @@protoc_insertion_point(class_definition:novonotes.audio_engine.v1alpha1.SaveStateResponse)
 */
{
   public:
    inline SaveStateResponse() : SaveStateResponse(nullptr) {}
    template <typename = void>
    explicit PROTOBUF_CONSTEXPR SaveStateResponse(
        ::google::protobuf::internal::ConstantInitialized);

    inline SaveStateResponse(const SaveStateResponse& from)
        : SaveStateResponse(nullptr, from)
    {}
    inline SaveStateResponse(SaveStateResponse&& from) noexcept
        : SaveStateResponse(nullptr, std::move(from))
    {}
    inline SaveStateResponse& operator=(const SaveStateResponse& from)
    {
        CopyFrom(from);
        return *this;
    }
    inline SaveStateResponse& operator=(SaveStateResponse&& from) noexcept
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
    static const SaveStateResponse& default_instance()
    {
        return *internal_default_instance();
    }
    static inline const SaveStateResponse* internal_default_instance()
    {
        return reinterpret_cast<const SaveStateResponse*>(
            &_SaveStateResponse_default_instance_);
    }
    static constexpr int kIndexInFileMessages = 3;
    friend void swap(SaveStateResponse& a, SaveStateResponse& b) { a.Swap(&b); }
    inline void Swap(SaveStateResponse* other)
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
    void UnsafeArenaSwap(SaveStateResponse* other)
    {
        if(other == this) return;
        ABSL_DCHECK(GetArena() == other->GetArena());
        InternalSwap(other);
    }

    // implements Message ----------------------------------------------

    SaveStateResponse* New(::google::protobuf::Arena* arena = nullptr) const
        PROTOBUF_FINAL
    {
        return ::google::protobuf::internal::ZeroFieldsBase::DefaultConstruct<
            SaveStateResponse>(arena);
    }
    using ::google::protobuf::internal::ZeroFieldsBase::CopyFrom;
    inline void CopyFrom(const SaveStateResponse& from)
    {
        ::google::protobuf::internal::ZeroFieldsBase::CopyImpl(*this, from);
    }
    using ::google::protobuf::internal::ZeroFieldsBase::MergeFrom;
    void MergeFrom(const SaveStateResponse& from)
    {
        ::google::protobuf::internal::ZeroFieldsBase::MergeImpl(*this, from);
    }

   public:
    bool IsInitialized() const { return true; }

   private:
    friend class ::google::protobuf::internal::AnyMetadata;
    static ::absl::string_view FullMessageName()
    {
        return "novonotes.audio_engine.v1alpha1.SaveStateResponse";
    }

   protected:
    explicit SaveStateResponse(::google::protobuf::Arena* arena);
    SaveStateResponse(::google::protobuf::Arena* arena,
                      const SaveStateResponse& from);
    SaveStateResponse(::google::protobuf::Arena* arena,
                      SaveStateResponse&& from) noexcept
        : SaveStateResponse(arena)
    {
        *this = ::std::move(from);
    }
    const ::google::protobuf::internal::ZeroFieldsBase::ClassData*
    GetClassData() const PROTOBUF_FINAL;
    static const ::google::protobuf::internal::ZeroFieldsBase::ClassDataFull
        _class_data_;

   public:
    ::google::protobuf::Metadata GetMetadata() const;
    // nested types ----------------------------------------------------

    // accessors -------------------------------------------------------
    // @@protoc_insertion_point(class_scope:novonotes.audio_engine.v1alpha1.SaveStateResponse)
   private:
    class _Internal;
    friend class ::google::protobuf::internal::TcParser;
    static const ::google::protobuf::internal::TcParseTable<0, 0, 0, 0, 2>
        _table_;

    static constexpr const void* _raw_default_instance_ =
        &_SaveStateResponse_default_instance_;

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
            const SaveStateResponse& from_msg);
        PROTOBUF_TSAN_DECLARE_MEMBER
    };
    friend struct ::
        TableStruct_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto;
};
// -------------------------------------------------------------------

class SaveStateRequest final : public ::google::protobuf::Message
/* @@protoc_insertion_point(class_definition:novonotes.audio_engine.v1alpha1.SaveStateRequest)
 */
{
   public:
    inline SaveStateRequest() : SaveStateRequest(nullptr) {}
    ~SaveStateRequest() PROTOBUF_FINAL;
    template <typename = void>
    explicit PROTOBUF_CONSTEXPR SaveStateRequest(
        ::google::protobuf::internal::ConstantInitialized);

    inline SaveStateRequest(const SaveStateRequest& from)
        : SaveStateRequest(nullptr, from)
    {}
    inline SaveStateRequest(SaveStateRequest&& from) noexcept
        : SaveStateRequest(nullptr, std::move(from))
    {}
    inline SaveStateRequest& operator=(const SaveStateRequest& from)
    {
        CopyFrom(from);
        return *this;
    }
    inline SaveStateRequest& operator=(SaveStateRequest&& from) noexcept
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
    static const SaveStateRequest& default_instance()
    {
        return *internal_default_instance();
    }
    static inline const SaveStateRequest* internal_default_instance()
    {
        return reinterpret_cast<const SaveStateRequest*>(
            &_SaveStateRequest_default_instance_);
    }
    static constexpr int kIndexInFileMessages = 2;
    friend void swap(SaveStateRequest& a, SaveStateRequest& b) { a.Swap(&b); }
    inline void Swap(SaveStateRequest* other)
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
    void UnsafeArenaSwap(SaveStateRequest* other)
    {
        if(other == this) return;
        ABSL_DCHECK(GetArena() == other->GetArena());
        InternalSwap(other);
    }

    // implements Message ----------------------------------------------

    SaveStateRequest* New(::google::protobuf::Arena* arena = nullptr) const
        PROTOBUF_FINAL
    {
        return ::google::protobuf::Message::DefaultConstruct<SaveStateRequest>(
            arena);
    }
    using ::google::protobuf::Message::CopyFrom;
    void CopyFrom(const SaveStateRequest& from);
    using ::google::protobuf::Message::MergeFrom;
    void MergeFrom(const SaveStateRequest& from)
    {
        SaveStateRequest::MergeImpl(*this, from);
    }

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
    void InternalSwap(SaveStateRequest* other);

   private:
    friend class ::google::protobuf::internal::AnyMetadata;
    static ::absl::string_view FullMessageName()
    {
        return "novonotes.audio_engine.v1alpha1.SaveStateRequest";
    }

   protected:
    explicit SaveStateRequest(::google::protobuf::Arena* arena);
    SaveStateRequest(::google::protobuf::Arena* arena,
                     const SaveStateRequest& from);
    SaveStateRequest(::google::protobuf::Arena* arena,
                     SaveStateRequest&& from) noexcept
        : SaveStateRequest(arena)
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
        kDestFilePathFieldNumber = 1,
    };
    // string dest_file_path = 1 [(.google.api.field_behavior) = REQUIRED];
    void clear_dest_file_path();
    const std::string& dest_file_path() const;
    template <typename Arg_ = const std::string&, typename... Args_>
    void set_dest_file_path(Arg_&& arg, Args_... args);
    std::string* mutable_dest_file_path();
    PROTOBUF_NODISCARD std::string* release_dest_file_path();
    void set_allocated_dest_file_path(std::string* value);

   private:
    const std::string& _internal_dest_file_path() const;
    inline PROTOBUF_ALWAYS_INLINE void _internal_set_dest_file_path(
        const std::string& value);
    std::string* _internal_mutable_dest_file_path();

   public:
    // @@protoc_insertion_point(class_scope:novonotes.audio_engine.v1alpha1.SaveStateRequest)
   private:
    class _Internal;
    friend class ::google::protobuf::internal::TcParser;
    static const ::google::protobuf::internal::TcParseTable<0, 1, 0, 71, 2>
        _table_;

    static constexpr const void* _raw_default_instance_ =
        &_SaveStateRequest_default_instance_;

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
            const SaveStateRequest& from_msg);
        ::google::protobuf::internal::ArenaStringPtr dest_file_path_;
        mutable ::google::protobuf::internal::CachedSize _cached_size_;
        PROTOBUF_TSAN_DECLARE_MEMBER
    };
    union
    {
        Impl_ _impl_;
    };
    friend struct ::
        TableStruct_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto;
};
// -------------------------------------------------------------------

class DebugStateResponse final : public ::google::protobuf::Message
/* @@protoc_insertion_point(class_definition:novonotes.audio_engine.v1alpha1.DebugStateResponse)
 */
{
   public:
    inline DebugStateResponse() : DebugStateResponse(nullptr) {}
    ~DebugStateResponse() PROTOBUF_FINAL;
    template <typename = void>
    explicit PROTOBUF_CONSTEXPR DebugStateResponse(
        ::google::protobuf::internal::ConstantInitialized);

    inline DebugStateResponse(const DebugStateResponse& from)
        : DebugStateResponse(nullptr, from)
    {}
    inline DebugStateResponse(DebugStateResponse&& from) noexcept
        : DebugStateResponse(nullptr, std::move(from))
    {}
    inline DebugStateResponse& operator=(const DebugStateResponse& from)
    {
        CopyFrom(from);
        return *this;
    }
    inline DebugStateResponse& operator=(DebugStateResponse&& from) noexcept
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
    static const DebugStateResponse& default_instance()
    {
        return *internal_default_instance();
    }
    static inline const DebugStateResponse* internal_default_instance()
    {
        return reinterpret_cast<const DebugStateResponse*>(
            &_DebugStateResponse_default_instance_);
    }
    static constexpr int kIndexInFileMessages = 1;
    friend void swap(DebugStateResponse& a, DebugStateResponse& b)
    {
        a.Swap(&b);
    }
    inline void Swap(DebugStateResponse* other)
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
    void UnsafeArenaSwap(DebugStateResponse* other)
    {
        if(other == this) return;
        ABSL_DCHECK(GetArena() == other->GetArena());
        InternalSwap(other);
    }

    // implements Message ----------------------------------------------

    DebugStateResponse* New(::google::protobuf::Arena* arena = nullptr) const
        PROTOBUF_FINAL
    {
        return ::google::protobuf::Message::DefaultConstruct<
            DebugStateResponse>(arena);
    }
    using ::google::protobuf::Message::CopyFrom;
    void CopyFrom(const DebugStateResponse& from);
    using ::google::protobuf::Message::MergeFrom;
    void MergeFrom(const DebugStateResponse& from)
    {
        DebugStateResponse::MergeImpl(*this, from);
    }

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
    void InternalSwap(DebugStateResponse* other);

   private:
    friend class ::google::protobuf::internal::AnyMetadata;
    static ::absl::string_view FullMessageName()
    {
        return "novonotes.audio_engine.v1alpha1.DebugStateResponse";
    }

   protected:
    explicit DebugStateResponse(::google::protobuf::Arena* arena);
    DebugStateResponse(::google::protobuf::Arena* arena,
                       const DebugStateResponse& from);
    DebugStateResponse(::google::protobuf::Arena* arena,
                       DebugStateResponse&& from) noexcept
        : DebugStateResponse(arena)
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
        kStateFieldNumber = 1,
    };
    // string state = 1;
    void clear_state();
    const std::string& state() const;
    template <typename Arg_ = const std::string&, typename... Args_>
    void set_state(Arg_&& arg, Args_... args);
    std::string* mutable_state();
    PROTOBUF_NODISCARD std::string* release_state();
    void set_allocated_state(std::string* value);

   private:
    const std::string& _internal_state() const;
    inline PROTOBUF_ALWAYS_INLINE void _internal_set_state(
        const std::string& value);
    std::string* _internal_mutable_state();

   public:
    // @@protoc_insertion_point(class_scope:novonotes.audio_engine.v1alpha1.DebugStateResponse)
   private:
    class _Internal;
    friend class ::google::protobuf::internal::TcParser;
    static const ::google::protobuf::internal::TcParseTable<0, 1, 0, 64, 2>
        _table_;

    static constexpr const void* _raw_default_instance_ =
        &_DebugStateResponse_default_instance_;

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
            const DebugStateResponse& from_msg);
        ::google::protobuf::internal::ArenaStringPtr state_;
        mutable ::google::protobuf::internal::CachedSize _cached_size_;
        PROTOBUF_TSAN_DECLARE_MEMBER
    };
    union
    {
        Impl_ _impl_;
    };
    friend struct ::
        TableStruct_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto;
};
// -------------------------------------------------------------------

class DebugStateRequest final
    : public ::google::protobuf::internal::ZeroFieldsBase
/* @@protoc_insertion_point(class_definition:novonotes.audio_engine.v1alpha1.DebugStateRequest)
 */
{
   public:
    inline DebugStateRequest() : DebugStateRequest(nullptr) {}
    template <typename = void>
    explicit PROTOBUF_CONSTEXPR DebugStateRequest(
        ::google::protobuf::internal::ConstantInitialized);

    inline DebugStateRequest(const DebugStateRequest& from)
        : DebugStateRequest(nullptr, from)
    {}
    inline DebugStateRequest(DebugStateRequest&& from) noexcept
        : DebugStateRequest(nullptr, std::move(from))
    {}
    inline DebugStateRequest& operator=(const DebugStateRequest& from)
    {
        CopyFrom(from);
        return *this;
    }
    inline DebugStateRequest& operator=(DebugStateRequest&& from) noexcept
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
    static const DebugStateRequest& default_instance()
    {
        return *internal_default_instance();
    }
    static inline const DebugStateRequest* internal_default_instance()
    {
        return reinterpret_cast<const DebugStateRequest*>(
            &_DebugStateRequest_default_instance_);
    }
    static constexpr int kIndexInFileMessages = 0;
    friend void swap(DebugStateRequest& a, DebugStateRequest& b) { a.Swap(&b); }
    inline void Swap(DebugStateRequest* other)
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
    void UnsafeArenaSwap(DebugStateRequest* other)
    {
        if(other == this) return;
        ABSL_DCHECK(GetArena() == other->GetArena());
        InternalSwap(other);
    }

    // implements Message ----------------------------------------------

    DebugStateRequest* New(::google::protobuf::Arena* arena = nullptr) const
        PROTOBUF_FINAL
    {
        return ::google::protobuf::internal::ZeroFieldsBase::DefaultConstruct<
            DebugStateRequest>(arena);
    }
    using ::google::protobuf::internal::ZeroFieldsBase::CopyFrom;
    inline void CopyFrom(const DebugStateRequest& from)
    {
        ::google::protobuf::internal::ZeroFieldsBase::CopyImpl(*this, from);
    }
    using ::google::protobuf::internal::ZeroFieldsBase::MergeFrom;
    void MergeFrom(const DebugStateRequest& from)
    {
        ::google::protobuf::internal::ZeroFieldsBase::MergeImpl(*this, from);
    }

   public:
    bool IsInitialized() const { return true; }

   private:
    friend class ::google::protobuf::internal::AnyMetadata;
    static ::absl::string_view FullMessageName()
    {
        return "novonotes.audio_engine.v1alpha1.DebugStateRequest";
    }

   protected:
    explicit DebugStateRequest(::google::protobuf::Arena* arena);
    DebugStateRequest(::google::protobuf::Arena* arena,
                      const DebugStateRequest& from);
    DebugStateRequest(::google::protobuf::Arena* arena,
                      DebugStateRequest&& from) noexcept
        : DebugStateRequest(arena)
    {
        *this = ::std::move(from);
    }
    const ::google::protobuf::internal::ZeroFieldsBase::ClassData*
    GetClassData() const PROTOBUF_FINAL;
    static const ::google::protobuf::internal::ZeroFieldsBase::ClassDataFull
        _class_data_;

   public:
    ::google::protobuf::Metadata GetMetadata() const;
    // nested types ----------------------------------------------------

    // accessors -------------------------------------------------------
    // @@protoc_insertion_point(class_scope:novonotes.audio_engine.v1alpha1.DebugStateRequest)
   private:
    class _Internal;
    friend class ::google::protobuf::internal::TcParser;
    static const ::google::protobuf::internal::TcParseTable<0, 0, 0, 0, 2>
        _table_;

    static constexpr const void* _raw_default_instance_ =
        &_DebugStateRequest_default_instance_;

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
            const DebugStateRequest& from_msg);
        PROTOBUF_TSAN_DECLARE_MEMBER
    };
    friend struct ::
        TableStruct_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto;
};

// ===================================================================

// ===================================================================

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// -------------------------------------------------------------------

// DebugStateRequest

// -------------------------------------------------------------------

// DebugStateResponse

// string state = 1;
inline void DebugStateResponse::clear_state()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.state_.ClearToEmpty();
}
inline const std::string& DebugStateResponse::state() const
    ABSL_ATTRIBUTE_LIFETIME_BOUND
{
    // @@protoc_insertion_point(field_get:novonotes.audio_engine.v1alpha1.DebugStateResponse.state)
    return _internal_state();
}
template <typename Arg_, typename... Args_>
inline PROTOBUF_ALWAYS_INLINE void DebugStateResponse::set_state(Arg_&& arg,
                                                                 Args_... args)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.state_.Set(static_cast<Arg_&&>(arg), args..., GetArena());
    // @@protoc_insertion_point(field_set:novonotes.audio_engine.v1alpha1.DebugStateResponse.state)
}
inline std::string* DebugStateResponse::mutable_state()
    ABSL_ATTRIBUTE_LIFETIME_BOUND
{
    std::string* _s = _internal_mutable_state();
    // @@protoc_insertion_point(field_mutable:novonotes.audio_engine.v1alpha1.DebugStateResponse.state)
    return _s;
}
inline const std::string& DebugStateResponse::_internal_state() const
{
    ::google::protobuf::internal::TSanRead(&_impl_);
    return _impl_.state_.Get();
}
inline void DebugStateResponse::_internal_set_state(const std::string& value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.state_.Set(value, GetArena());
}
inline std::string* DebugStateResponse::_internal_mutable_state()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    return _impl_.state_.Mutable(GetArena());
}
inline std::string* DebugStateResponse::release_state()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    // @@protoc_insertion_point(field_release:novonotes.audio_engine.v1alpha1.DebugStateResponse.state)
    return _impl_.state_.Release();
}
inline void DebugStateResponse::set_allocated_state(std::string* value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.state_.SetAllocated(value, GetArena());
#ifdef PROTOBUF_FORCE_COPY_DEFAULT_STRING
    if(_impl_.state_.IsDefault())
    {
        _impl_.state_.Set("", GetArena());
    }
#endif  // PROTOBUF_FORCE_COPY_DEFAULT_STRING
    // @@protoc_insertion_point(field_set_allocated:novonotes.audio_engine.v1alpha1.DebugStateResponse.state)
}

// -------------------------------------------------------------------

// SaveStateRequest

// string dest_file_path = 1 [(.google.api.field_behavior) = REQUIRED];
inline void SaveStateRequest::clear_dest_file_path()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.dest_file_path_.ClearToEmpty();
}
inline const std::string& SaveStateRequest::dest_file_path() const
    ABSL_ATTRIBUTE_LIFETIME_BOUND
{
    // @@protoc_insertion_point(field_get:novonotes.audio_engine.v1alpha1.SaveStateRequest.dest_file_path)
    return _internal_dest_file_path();
}
template <typename Arg_, typename... Args_>
inline PROTOBUF_ALWAYS_INLINE void SaveStateRequest::set_dest_file_path(
    Arg_&& arg, Args_... args)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.dest_file_path_.Set(static_cast<Arg_&&>(arg), args..., GetArena());
    // @@protoc_insertion_point(field_set:novonotes.audio_engine.v1alpha1.SaveStateRequest.dest_file_path)
}
inline std::string* SaveStateRequest::mutable_dest_file_path()
    ABSL_ATTRIBUTE_LIFETIME_BOUND
{
    std::string* _s = _internal_mutable_dest_file_path();
    // @@protoc_insertion_point(field_mutable:novonotes.audio_engine.v1alpha1.SaveStateRequest.dest_file_path)
    return _s;
}
inline const std::string& SaveStateRequest::_internal_dest_file_path() const
{
    ::google::protobuf::internal::TSanRead(&_impl_);
    return _impl_.dest_file_path_.Get();
}
inline void SaveStateRequest::_internal_set_dest_file_path(
    const std::string& value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.dest_file_path_.Set(value, GetArena());
}
inline std::string* SaveStateRequest::_internal_mutable_dest_file_path()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    return _impl_.dest_file_path_.Mutable(GetArena());
}
inline std::string* SaveStateRequest::release_dest_file_path()
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    // @@protoc_insertion_point(field_release:novonotes.audio_engine.v1alpha1.SaveStateRequest.dest_file_path)
    return _impl_.dest_file_path_.Release();
}
inline void SaveStateRequest::set_allocated_dest_file_path(std::string* value)
{
    ::google::protobuf::internal::TSanWrite(&_impl_);
    _impl_.dest_file_path_.SetAllocated(value, GetArena());
#ifdef PROTOBUF_FORCE_COPY_DEFAULT_STRING
    if(_impl_.dest_file_path_.IsDefault())
    {
        _impl_.dest_file_path_.Set("", GetArena());
    }
#endif  // PROTOBUF_FORCE_COPY_DEFAULT_STRING
    // @@protoc_insertion_point(field_set_allocated:novonotes.audio_engine.v1alpha1.SaveStateRequest.dest_file_path)
}

// -------------------------------------------------------------------

// SaveStateResponse

#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif  // __GNUC__

// @@protoc_insertion_point(namespace_scope)
}  // namespace v1alpha1
}  // namespace audio_engine
}  // namespace novonotes

// @@protoc_insertion_point(global_scope)

#include "google/protobuf/port_undef.inc"

#endif  // GOOGLE_PROTOBUF_INCLUDED_novonotes_2faudio_5fengine_2fv1alpha1_2fdebug_5futility_2eproto_2epb_2eh
