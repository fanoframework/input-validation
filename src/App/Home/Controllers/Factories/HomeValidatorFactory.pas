(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeValidatorFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller THomeController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeValidatorFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

    function THomeValidatorFactory.build(const container : IDependencyContainer) : IDependency;
    var rules : IValidationRules;
    begin
        rules := TValidation.create(THashList.create());

        //field id is required and must be integer value greater than 0
        rules.addRule(
            'id',
            TAndValidator.create([
                TRequiredValidator.create(),
                TIntegerValidator.create(),
                TGreaterThanValidator.create(0)
            ])
        );

        //field latitude is required and must be valid latitude value
        rules.addRule(
            'latitude',
            TAndValidator.create([
                TRequiredValidator.create(),
                TLatitudeValidator.create()
            ])
        );

        //field longitude is required and must be valid longitude value
        rules.addRule(
            'longitude',
            TAndValidator.create([
                TRequiredValidator.create(),
                TLongitudeValidator.create()
            ])
        );

        result := rules as IDependency;
    end;
end.
