#pragma once
#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/Common/Ids.h>

#include <string>
#include <unordered_map>

#include "../EngineKernel.h"

namespace novonotes
{

class IdMapper
{
   public:
    /// 型パラメーター AppId に渡せるのは AppSpecifiedId を継承したクラスだけ。
    template <typename AppId, typename = std::enable_if_t<
                                  std::is_base_of_v<AppSpecifiedId, AppId>>>
    void mapId(const AppId& appId, tracktion::engine::EditItemID teId)
    {
        const std::string& value = appId.getValue();
        if(_appToTeMap.find(value) != _appToTeMap.end())
        {
            throw AlreadyExistsError{"ID mapping already exists: " + value};
        }

        _appToTeMap[value] = teId;
        _teToAppMap[teId] = std::make_unique<AppId>(appId);
    }

    tracktion::engine::EditItemID getTeId(const AppSpecifiedId& appId) const
    {
        const std::string& value = appId.getValue();
        auto it = _appToTeMap.find(value);
        if(it == _appToTeMap.end())
        {
            throw NotFoundError{"ID mapping not found: " + value};
        }
        return it->second;
    }

    template <typename AppId, typename = std::enable_if_t<
                                  std::is_base_of_v<AppSpecifiedId, AppId>>>
    AppId getAppId(const tracktion::engine::EditItemID& teId) const
    {
        auto it = _teToAppMap.find(teId);
        if(it == _teToAppMap.end())
        {
            throw InternalError{"ID mapping not found"};
        }
        const auto* appId = dynamic_cast<AppId*>(it->second.get());
        if(!appId)
        {
            throw InternalError{"Type mismatch in ID mapping"};
        }
        return *appId;
    }

    void removeMapping(const AppSpecifiedId& appId)
    {
        const std::string& value = appId.getValue();
        auto it = _appToTeMap.find(value);
        if(it == _appToTeMap.end())
        {
            throw NotFoundError{"ID mapping not found: " + value};
        }

        _teToAppMap.erase(it->second);
        _appToTeMap.erase(it);
    }

   private:
    using AppToTeMap =
        std::unordered_map<std::string, tracktion::engine::EditItemID>;
    using TeToAppMap = std::unordered_map<tracktion::engine::EditItemID,
                                          std::unique_ptr<AppSpecifiedId>>;

    AppToTeMap _appToTeMap;
    TeToAppMap _teToAppMap;
};

}  // namespace novonotes
