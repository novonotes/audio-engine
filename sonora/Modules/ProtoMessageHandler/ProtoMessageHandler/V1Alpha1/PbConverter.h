#pragma once

#include <AudioEngineCore/StudioService.h>
#include <novonotes/audio_engine/v1alpha1/device_instance.pb.h>

namespace pb
{
using namespace novonotes::audio_engine::v1alpha1;
using namespace google::protobuf;
}  // namespace pb

namespace novonotes
{

class DeviceInstancePbConverter
{
   public:
    DeviceInstancePbConverter(StudioService& s) : _studioService(s) {}

    pb::DeviceInstance convertToPbMessage(const DeviceInstance& instance)
    {
        pb::DeviceInstance pbInstance;

        // DeviceInstance の基本フィールドの変換
        pbInstance.set_id(instance.id.value);
        pbInstance.set_device_type_id(instance.deviceTypeId.value);
        pbInstance.set_state_restoration_token(instance.serializedState);

        // 現在複数の inlet/outlet には対応していないため、固定値を挿入。
        // 将来的には AudioProcessor の Bus を inlet/outlet に対応させたい。
        auto* inlet = pbInstance.add_inlets();
        inlet->set_display_name("In 1");
        auto* outlet = pbInstance.add_outlets();
        outlet->set_display_name("Out 1");

        for(const auto& param : instance.parameters)
        {
            // プロト定義上は map のキーとして parameterId を用いる
            auto& pbParam =
                (*pbInstance.mutable_parameters())[param.parameterId.value];
            pbParam.set_id(param.parameterId.value);
            pbParam.set_display_name(param.displayName);
            pbParam.set_default_value(param.textDefaultValue);
            pbParam.set_parameter_sync_key(param.parameterSyncKey);

            // 現在の数値パラメーターの値を取得し、テキスト表現へ変換
            float normalizedVal = _studioService.getParameterUnmodulatedValue(
                instance.id, param.parameterId);
            std::string textVal =
                _studioService
                    .parameterValueToString(instance.id, param.parameterId,
                                            normalizedVal)
                    .toStdString();
            pbParam.set_current_value(textVal);

            // パラメーターの詳細（Numeric か Choice か）に応じて oneof 内を設定
            if(auto* numeric =
                   std::get_if<NumericParameterDetails>(&param.details))
            {
                auto* pbNumeric = pbParam.mutable_numeric();
                pbNumeric->set_normalized_current_value(normalizedVal);
                pbNumeric->set_normalized_default_value(
                    numeric->normalizedDefaultValue);
                pbNumeric->set_min_value(numeric->minValue);
                pbNumeric->set_max_value(numeric->maxValue);
                pbNumeric->set_step_count(numeric->stepCount);
            }
            else if(auto* choice =
                        std::get_if<ChoiceParameterDetails>(&param.details))
            {
                auto* pbChoice = pbParam.mutable_choice();
                for(const auto& option : choice->options)
                {
                    pbChoice->add_options(option);
                }
            }
        }

        return pbInstance;
    }

   private:
    StudioService& _studioService;
};

}  // namespace novonotes
