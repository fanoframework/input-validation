(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your middleware-related dependencies registration here---}
    container.add(
        'verifyCsrfToken',
        TCsrfMiddlewareFactory.create(
            (container[GuidToString(IAppConfiguration)] as IAppConfiguration)
                .getString('secretKey')
        )
    );

    (container['appMiddlewares'] as IMiddlewareList)
        .add(container['verifyCsrfToken'] as IMiddleware);


container.add('home.validation.rule', THomeValidatorFactory.create());
