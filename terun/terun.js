const basePath = "../lib/src/features"
const modelName = "{{model | lowercase | underscore}}";

const modelAndMapper = {
    args: ["model"],
    transports: [
        {
            from: "templates/model_and_mapper/domain/models/model.terun",
            to: `${basePath}/${modelName}/domain/models/${modelName}_model.dart`,
        },
        {
            from: "templates/model_and_mapper/domain/domain.terun",
            to: `${basePath}/${modelName}/domain/domain.dart`,
        },
        {
            from: "templates/model_and_mapper/data/mapper/mapper.terun",
            to: `${basePath}/${modelName}/data/mapper/${modelName}_mapper.dart`,
        },
        {
            from: "templates/model_and_mapper/data/data.terun",
            to: `${basePath}/${modelName}/data/data.dart`,
        },
        {
            from: "templates/model_and_mapper/export.terun",
            to: `${basePath}/${modelName}/${modelName}.dart`,
        },
    ],
}

module.exports = {
    commands: {
        modelAndMapper,
    }
};