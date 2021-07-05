(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

router.get(
    '/',
    container.get('homeController') as IRequestHandler
).add(
    TValidationMiddlewareWithHandler.create(
        container['home.validation.rule'] as IRequestValidator,
        TValidationErrorHandler.create(
            container['home.validation.rule'] as IRequestValidator
        )
    )
);
